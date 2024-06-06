import 'package:buzz_hub/services/dto/responses/get_all_user_response.dart';
import 'package:buzz_hub/services/get_all_user_service.dart';

class SearchBarController {
  final GetAllUserService _getAllUserService;

  SearchBarController(this._getAllUserService);

  Future<List<UserResponse>?> searchUsers(String query) async {
    try {
      // Call the service to get all users
      final allUsers = await _getAllUserService.getAllUsers();

      if (allUsers != null) {
        // Filter users based on the search query
        final filteredUsers = allUsers.where((user) {
          final userName = user.userName.toLowerCase();
          final fullName = user.fullName.toLowerCase();
          final lowerQuery = query.toLowerCase();
          return userName.contains(lowerQuery) || fullName.contains(lowerQuery);
        }).toList();

        return filteredUsers;
      } else {
        // Handle error case (e.g., log error, show a message, etc.)
        return null;
      }
    } catch (e) {
      // Handle exceptions (e.g., network error, parsing error, etc.)
      return null;
    }
  }
}