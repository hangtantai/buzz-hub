import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:buzz_hub/core/values/app_colors.dart';
import 'accountdetails_page.dart';

class EditBirthdayPage extends StatefulWidget {
  @override
  _EditBirthdayPageState createState() => _EditBirthdayPageState();
}

class _EditBirthdayPageState extends State<EditBirthdayPage> {
  //final TextEditingController _usernameController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd MMM, yyyy");
  DateTime dateOfBirth = DateTime(1990, 7, 23);

  @override
  void dispose() {
    //_usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Ngày sinh',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              Iconsax.cake,
              size: 80,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ngày sinh chỉ có thể thay đổi một lần.',
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ngày sinh',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900), 
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null && pickedDate != dateOfBirth) {
                  setState(() {
                    dateOfBirth = pickedDate;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:12, vertical: 19),                
                  child: Row(
                    children: [
                      Text(
                        dateFormat.format(dateOfBirth),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                        SizedBox(width: 8),                    
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            
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