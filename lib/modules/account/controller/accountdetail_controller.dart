import 'package:buzz_hub/services/dto/responses/current_user_response.dart';
import 'package:buzz_hub/services/user_service.dart';
import 'package:get/get.dart';

class AccountDetailController extends GetxController {
  Rx<CurrentUserResponse?> currentUser = Rx<CurrentUserResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser(); 
  }

  Future<void> fetchCurrentUser() async {
    UserService userService = UserService();
    final res = await userService.getCurrentUser();
    currentUser.value = res; 
  }
}
