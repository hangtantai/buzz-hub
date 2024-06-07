import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/auth/views/home_page.dart';
import 'package:buzz_hub/modules/bookmarks/views/bookmarks_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart'; 
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:buzz_hub/modules/post/controller/create_post_controller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:buzz_hub/modules/account/controller/accountdetail_controller.dart';
import 'package:buzz_hub/modules/auth/views/login_page.dart';


class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePost> {
  String _selectedPrivacy = 'Công khai';
  List<XFile> _mediaFiles = [];
  List<File?> _thumbnail = [];

  //List<VideoPlayerController?> _videoControllers = [];

  CreatePostController _textController = Get.put(CreatePostController());
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo bài viết'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [              
              Row(                                
                children: [                  
                  CircleAvatar(
                    //backgroundImage: AssetImage('assets/avatar.png'), 
                    //backgroundImage: NetworkImage('https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/${LoginPage.currentUser!.avatarUrl!}'),
                    radius: 30,
                  ),
              
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LoginPage.currentUser!.fullName!,
                        //'Consul of Design',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 4),
                          DropdownButtonHideUnderline(
                            child: Container( 
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8,),
                              child: DropdownButton<String>(
                              value: _selectedPrivacy,
                              isDense: true,
                              alignment: Alignment.center,
                              items: <String>['Công khai', 'Bạn bè', 'Riêng tư']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Icon(
                                        value == 'Công khai' ? Icons.public_outlined :
                                        value == 'Bạn bè' ? Icons.group_outlined :
                                        Icons.lock_outlined,
                                        size: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(value, style: TextStyle(fontSize: 13),),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPrivacy = newValue!;
                                });
                              },
                            ),
                          ),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.grey),
                    //borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _textController.textController,
                    style: //font color
                    TextStyle(color: Colors.black),
                    //controller: _textController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Bạn đang nghĩ gì?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8.0),
                    ),
                  ),
                ),
              ),
              _buildMediaGrid(),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Iconsax.camera),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(Iconsax.video),
                    onPressed: () {
                      _pickVideo(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(Iconsax.gallery),                    
                    onPressed: () {
                      //_pickImage(ImageSource.gallery);
                      _pickMedia();
                    },
                  ),
                  IconButton(
                    icon: Icon(Iconsax.task),
                    onPressed: (){

                    }
                  ), 
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      XFile? selectedMedia = _mediaFiles.isNotEmpty ? _mediaFiles[0] : null;              
                      
                      final success = _mediaFiles.isNotEmpty 
                        ? await _textController.createMediaPost(_textController.textController.text, _mediaFiles[0])
                        : await _textController.createTextPost(_textController.textController.text); 
                      
                      //final success = 
                      if (success) {                            
                        Get.snackbar(
                          'Thông báo',
                          'Đã đang bài viết',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,  
                        );
                      }                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Đăng bài', 
                      style: TextStyle(color: Colors.white),
                      ),
                  ),
                  Obx(() {
                    if (_textController.errorMessage.isNotEmpty) {
                      Get.snackbar(
                        'Lỗi',
                        _textController.errorMessage.value,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      _textController.errorMessage.value = "";
                    }
                    return SizedBox.shrink(); 
                  }),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildMediaGrid() {
    return Container(
      height: 120,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _mediaFiles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                //
                child: _mediaFiles[index].path.endsWith('.mp4') 
                  ? _thumbnail[index] != null
                    ? Image.file(
                        _thumbnail[index]!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 214,
                      )
                    : Center(child: CircularProgressIndicator())
                  : Image.file(
                    File(_mediaFiles[index].path),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 214,
                  ),
              ),                              
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _mediaFiles.removeAt(index);
                      _thumbnail.removeAt(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(3),
                    margin: EdgeInsets.only(right:4,top:4),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ),
              ),
              if (_mediaFiles[index].path.endsWith('.mp4')) 
                Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: AppColors.Purple,
                    fill: 1,
                    size: 48,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _mediaFiles.add(pickedFile);
        _thumbnail.add(null);
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);
    if (pickedFile != null) {
      final videoFile = File(pickedFile.path);
      final thumbnail = await _generateThumbnail(videoFile);
      
      setState(() {
        _mediaFiles.add(pickedFile);
        _thumbnail.add(thumbnail);
      });
    }
  }

  Future<void> _pickMedia() async {
  final ImagePicker _picker = ImagePicker();

  final option = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Chọn loại phương tiện'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'image');
            },
            child: const Text('Ảnh'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'video');
            },
            child: const Text('Video'),
          ),
        ],
      );
    },
  );

  if (option == 'image') {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _mediaFiles.add(image);
        _thumbnail.add(null);
      });
    }
  } else if (option == 'video') {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _addVideo(video);
    }
  }
}

Future<void> _addVideo(XFile video) async {
  final videoFile = File(video.path);
  final thumbnail = await _generateThumbnail(videoFile);
  
  setState(() {
    _mediaFiles.add(video);
    _thumbnail.add(thumbnail);
    print('Video added: ' + video.path);
  });
}

Future<File?> _generateThumbnail(File videoFile) async {
    final String? thumbPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 120, 
      quality: 75,
    );
    if (thumbPath != null) {
      return File(thumbPath);
    }
    return null;
  }
}