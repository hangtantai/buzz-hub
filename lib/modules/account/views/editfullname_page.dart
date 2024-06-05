import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:buzz_hub/modules/account/controller/accountdetail_controller.dart';
import 'package:buzz_hub/modules/account/controller/editfullname_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';


class EditFullnamePage extends StatefulWidget {
  @override
  _EditFullnamePageState createState() => _EditFullnamePageState();
}

class _EditFullnamePageState extends State<EditFullnamePage> {
  final EditFullNameController controller = Get.put(EditFullNameController());
  final AccountDetailController accountDetailController = Get.find<AccountDetailController>();
  
  @override
  void initState() {
    super.initState();
    //controller.fullNameController.text = accountDetailController.currentUser.value!.fullName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    const containerHeight = 60.0;
    const containerPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 19.0);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Thay đổi Họ Tên',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          } ,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Iconsax.user_edit,
              size: 80,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bạn có thể thay đổi Họ Tên một lần trong một tháng.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child:  Padding(
                padding: containerPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Old',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),                    
                    Text(
                      accountDetailController.currentUser.value!.fullName ?? "Chưa đặt tên",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:12, vertical: 7),                
                child: Row(
                  children: [
                    const Text(
                      'New',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          //Text('@'),
                          Expanded(
                            child: TextField(
                              controller: controller.fullNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                //contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                contentPadding: EdgeInsets.zero,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),                              
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            
            Obx(
              () => InkWell(
                onTap: controller.isLoading.value
                    ? null 
                    : () async {
                        final success = await controller.updateFullName(
                          controller.fullNameController.text);
                          if (success) {                            
                            Get.snackbar(
                              'Thông báo',
                              'Cập nhật Họ Tên thành công.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,  
                            );
                            Get.find<AccountDetailController>().fetchCurrentUser(); // Fetch updated data
                            //Get.back();                  
                            Navigator.pop(context);
                          }
                        },                                            
                
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: controller.isLoading.value ? Colors.grey : AppColors.Purple, 
                  ),
                  child: Center( 
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white) 
                        : const Text(
                            'Lưu thay đổi',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility( 
                visible: controller.errorMessage.isNotEmpty,
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}