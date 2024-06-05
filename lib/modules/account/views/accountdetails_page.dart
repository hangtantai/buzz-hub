import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:buzz_hub/modules/account/controller/accountdetail_controller.dart';
import 'editfullname_page.dart';
import 'editemail_page.dart';
import 'editphonenumber_page.dart';
import 'editbirthday_page.dart';
import 'editpassword_page.dart';
import 'package:get/get.dart';



class AccountDetailsPage extends StatefulWidget {
  // AccountDetailsPage({super.key}){
  //   initializeDateFormatting('vi', null);
    
    @override
    _AccountDetailsPageState createState() => _AccountDetailsPageState();
}


enum EditPageType { fullName, email, dob } 
class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final AccountDetailController _accountDetailController = Get.put(AccountDetailController());
  
  final DateFormat dateFormat = DateFormat("dd MMM, yyyy");
  String phoneNumber = '0923456789';

  @override
  void initState() {
    super.initState();
    _accountDetailController.fetchCurrentUser();
  }
  
  Future<void> navigateToEditPage(EditPageType pageType) async {
  Widget page;
  switch (pageType) {
    case EditPageType.fullName:
      page = EditFullnamePage();
      break;
    case EditPageType.email:
      page = EditEmailPage();
      break;
    case EditPageType.dob:
      page = EditBirthdayPage();
      break;
  }

  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );

  if (result != null && result == true) {
    _accountDetailController.fetchCurrentUser();
  }
}

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Row(
            children: <Widget>[Icon(Icons.arrow_back)],
          ),
        ),
        middle: const Text(
          'Thông tin tài khoản',
          style: TextStyle(color: Colors.black), 
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Obx(() {
          final user = _accountDetailController.currentUser.value;

          String fullName = user?.fullName ?? 'Họ Tên';
          String email = user?.email ?? 'email@gmail.com';
          DateTime dateOfBirth = user?.dob ?? DateTime(1990, 1, 1); 

          return SettingsList(
            applicationType: ApplicationType.cupertino,
            platform: DevicePlatform.iOS,
            lightTheme: true
              ? null
              : SettingsThemeData(
                settingsListBackground: Colors.white,
              ),
            sections: [
              SettingsSection(
                title: const Text('Thông tin cá nhân'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    onPressed: (context) {
                      navigateToEditPage(EditPageType.fullName);
                    },
                      
                    leading: const Icon(
                      Iconsax.user_edit,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Họ Tên', 
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: Text(fullName),
                  ),
                  
                  SettingsTile.navigation(
                    onPressed: (context) {
                      navigateToEditPage(EditPageType.email);
                    },
                    leading: const Icon(
                      Iconsax.sms,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Email', 
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: Text(email),
                  ),
                  
                  SettingsTile.navigation(
                      onPressed: (context) {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPhonenumberPage(),
                        ) 
                        );
                      },
                      leading: const Icon(
                        Iconsax.call,
                        color: Colors.black,
                        ),
                      title: const Text(
                        'Số điện thoại', 
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      value: Text(phoneNumber),
                    ),              
                  SettingsTile.navigation(
                    onPressed: (context) {
                      navigateToEditPage(EditPageType.dob);
                    },
                    leading: const Icon(
                      Iconsax.calendar,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Ngày sinh', 
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: Text(dateFormat.format(dateOfBirth)),
                  ),
                ],
              ),    
              SettingsSection(
                title: const Text('Khác'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    onPressed: (context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPasswordPage()
                        ),
                      );
                    },
                    leading: const Icon(
                      Iconsax.password_check,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Mật khẩu',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: const Text('Thay đổi mật khẩu'),
                    )
                ],
              )        
            ],
          );
        })
      ),
    );
  }
}
