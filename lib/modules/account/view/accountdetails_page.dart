import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'editusername_page.dart';
import 'editemail_page.dart';
import 'editphonenumber_page.dart';
import 'editbirthday_page.dart';
import 'editpassword_page.dart';

class AccountDetailsPage extends StatelessWidget {
  AccountDetailsPage({super.key}){
    initializeDateFormatting('vi', null);
  }

  String username = 'username';
  String email = 'email@gmail.com';
  String phoneNumber = '09000000';
  
  DateFormat dateFormat = DateFormat("dd MMM, yyyy");
  DateTime dateOfBirth = DateTime(1990, 7, 23);

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
        child: SettingsList(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUsernamePage(),
                      ),
                    );
                  },
                  leading: const Icon(
                    Iconsax.user_edit,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Tên người dùng', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: Text('@'+username),
                ),
                
                SettingsTile.navigation(
                  onPressed: (context) {
                    Navigator.push(
                     context,
                     MaterialPageRoute(
                      builder: (context) => EditEmailPage(),
                     ) 
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditBirthdayPage()
                      ),
                    );
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
        ),
      ),
    );
  }
}
