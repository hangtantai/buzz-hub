import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/conversation/controller/conversation_controller.dart';
import 'package:buzz_hub/services/dto/responses/conversation_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ConversationPage extends StatelessWidget {
  ConversationPage({super.key});
  ConversationController controller = Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F2FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F2FF),
        toolbarHeight: 80,
        leading: Container(
          margin: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.fpt.shop/unsafe/filters:quality(5)/fptshop.com.vn/uploads/images/tin-tuc/158160/Originals/2%20(7).jpg'),
          ),
        ),
        title: Text(
          'Tin nhắn',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {},
            child: Container(
              margin: EdgeInsets.only(right: 4),
              padding: EdgeInsets.all(4),
              child: Icon(Icons.search, color: Colors.white),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.Pink),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(right: 4),
              padding: EdgeInsets.all(4),
              child: Icon(Icons.add, color: Colors.white),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.Purple),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bạn bè',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return friendItem();
                      },
                      itemCount: 6,
                      separatorBuilder: (context, index) => SizedBox(width: 12),
                    ),
                  )
                ],
              )),
          Expanded(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(20),
              child: Obx(() => ListView.builder(
                  itemCount: controller.listConversation.length,
                  itemBuilder: (context, index) {
                    ConversationResponse item =
                        controller.listConversation[index];
                    return conversationItem(
                        item.conversationAvatar,
                        item.conversationName,
                        item.lastMessage.content ?? "",
                        '2 min ago');
                  })),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget friendItem() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://images.fpt.shop/unsafe/filters:quality(5)/fptshop.com.vn/uploads/images/tin-tuc/158160/Originals/2%20(7).jpg'),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Jane',
            style:
                TextStyle(fontWeight: FontWeight.w400, color: AppColors.DarkBg),
          )
        ],
      ),
    );
  }

  Widget conversationItem(
      String avt, String name, String lastMsg, String lastTime) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://goexjtmckylmpnrbxtcn.supabase.co/storage/v1/object/public/users-avatar/' +
                    avt),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Text(
                  lastMsg,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: AppColors.Grey2),
                )
              ],
            ),
          ),
          Text(
            lastTime,
            style:
                TextStyle(fontWeight: FontWeight.w500, color: AppColors.Grey2),
          )
        ],
      ),
    );
  }
}
