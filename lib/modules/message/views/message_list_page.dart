import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/core/values/constant.dart';
import 'package:buzz_hub/modules/auth/controller/login_controller.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';
import 'package:buzz_hub/modules/root_view/controller/root_view_controller.dart';
import 'package:buzz_hub/services/conversation_service.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/dto/responses/message_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MessageListPage extends StatefulWidget {
  const MessageListPage({super.key, required this.conversation});
  final ConversationResponse conversation;

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}


class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 4;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            key: key,
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: wid,
              height: wid,
              child: Image.asset(
                'assets/images/loader.gif',
              ),
            ));
      },
    );
  }
}

class _MessageListPageState extends State<MessageListPage> {
  List<types.Message> _messages = [];
  final _user = types.User(
      id: LoginPage.currentUser!.userName!,
      imageUrl:
          'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/' +
              LoginPage.currentUser!.avatarUrl!);
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  List<StreamSubscription> subscriptions = [];
  ConversationService service = ConversationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoaderDialog.showLoadingDialog(context, _LoaderDialog);
      _loadMessages();
    });
   
    subscriptions.addAll([
      LoginController.messageReceivedStreamCtrl.stream.listen((message) {
        if (message.messageType == "text") {
          final textMessage = types.TextMessage(
            author: types.User(
                id: message.senderId!,
                imageUrl:
                    'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/user-ronaldo'),
            createdAt: 1,
            id: const Uuid().v4(),
            text: message.content!,
          );
          _addMessage(textMessage);
        } else if (message.messageType == "image") {
          final image = Image.network(message.content!);

          final imageMessage = types.ImageMessage(
            author: types.User(
                id: message.senderId!,
                imageUrl:
                    'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/user-ronaldo'),
            createdAt: 1,
            id: const Uuid().v4(),
            height: image.height,
            name: '',
            size: 1000,
            uri: message.content!,
            width: image.width,
          );
          _addMessage(imageMessage);
        }
      }),
    ]);
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      service.sendFileMessage(
        conversationId: widget.conversation.conversationId,
        messageType: 'image',
        xfile: result,
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    await LoginController.connection!.invoke('SendPeerMessage',
        args: [widget.conversation.conversationId, "text", message.text]);

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    // final response = await rootBundle.loadString('assets/messages.json');
    final messages =
        await service.getMessagesFromAConversation(widget.conversation);

    setState(() {
      _messages = convertMessageToWidget(messages!);
    });
     Navigator.of(_LoaderDialog.currentContext!, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/' +
                        widget.conversation.conversationAvatar),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  widget.conversation.conversationName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () async {},
              child: Container(
                margin: EdgeInsets.only(right: 4),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: DefaultChatTheme(
            inputBackgroundColor: AppColors.Grey,
            inputBorderRadius: BorderRadius.circular(20),
            inputMargin: EdgeInsets.all(8),
            inputTextColor: AppColors.DarkGrey,
            seenIcon: Text(
              'read',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      );
}

List<types.Message> convertMessageToWidget(List<MessageResponse> messageList) {
  List<types.Message> widgets = [];

  for (MessageResponse message in messageList) {
    if (message.messageType == "text") {
      final textMessageUI = types.TextMessage(
        author: types.User(
            id: message.senderId!,
            imageUrl:
                'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/user-ronaldo'),
        createdAt: convertDateTimeToTimestamp(message.sentAt!.add(Duration(hours: 7))),
        id: const Uuid().v4(),
        text: message.content!,
      );
      widgets.insert(0, textMessageUI);
    } else if (message.messageType == "image") {
      final image = Image.network(message.content!);

      final messageImageUI = types.ImageMessage(
        author: types.User(
            id: message.senderId!,
            imageUrl:
                'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/user-ronaldo'),
        createdAt: convertDateTimeToTimestamp(message.sentAt!.add(Duration(hours: 7))),
        id: const Uuid().v4(),
        height: image.height,
        name: '',
        size: 1000,
        uri: message.content!,
        width: image.width,
      );
      widgets.insert(0, messageImageUI);
    }
  }
  return widgets;
}

int convertDateTimeToTimestamp(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch ;
}
