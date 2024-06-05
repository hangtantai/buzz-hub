import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:buzz_hub/core/values/app_colors.dart';
import 'package:country_picker/country_picker.dart';

class EditPhonenumberPage extends StatefulWidget {
  EditPhonenumberPage({super.key});
  @override
  State<EditPhonenumberPage> createState() {
    return _EditPhonenumberPageState();
  }
}

class _EditPhonenumberPageState extends State<EditPhonenumberPage> {
  final TextEditingController _usernameController = TextEditingController();
  String phoneNumber = '';
  String phoneCode = '84';
  String countryName = 'Vietnam';
  String countryCode = 'VN';
  String flag = 'VN'.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
     (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

  @override
  Widget build(BuildContext context) {
    const containerHeight = 60.0;
    const containerPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 19.0);
    
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Số điện thoại',
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
              Iconsax.call,
              size: 80,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            const SizedBox(height: 10),
            const Text(
              'Số điện thoại của bạn đã được liên kết với tài khoản. Bạn có thể thay đổi số điện thoại dưới đây.',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            GestureDetector(      
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    setState(() {
                      //countryName = country.displayName; 
                      countryName = country.name;                      
                      phoneCode = country.phoneCode;                      
                      flag = country.flagEmoji;
                    });
                  },
                );
              },
              child:       
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    border: Border.all(color: Colors.grey.shade200),
                  ),              
                  child: Padding(
                    padding: containerPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                        Text(
                          flag+' '+countryName+'(+'+phoneCode+')',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ), 
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Iconsax.arrow_down_1
                          ),
                        )                                     
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
                    Text(
                      '+'+phoneCode,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              //controller: _usernameController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                //contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                contentPadding: EdgeInsets.zero,
                                floatingLabelBehavior: FloatingLabelBehavior.never,                                
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,),                              
                              textAlign: TextAlign.left,

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