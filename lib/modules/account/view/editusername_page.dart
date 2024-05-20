import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:buzz_hub/core/values/app_colors.dart';
import 'accountdetails_page.dart';

class EditUsernamePage extends StatefulWidget {
  @override
  _EditUsernamePageState createState() => _EditUsernamePageState();
}

class _EditUsernamePageState extends State<EditUsernamePage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const containerHeight = 60.0;
    const containerPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 19.0);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Thay đổi tên người dùng',
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
              'Bạn có thể thay đổi tên người dùng một lần trong một tháng.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Padding(
                padding: containerPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Old',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),                    
                    Text(
                      '@'+AutofillHints.username,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
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
                          Text('@'),
                          Expanded(
                            child: TextField(
                              controller: _usernameController,
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
            
            InkWell(
              onTap: () async {
                                  
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.Purple),
                child: const Text(
                  'Lưu thay đổi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}