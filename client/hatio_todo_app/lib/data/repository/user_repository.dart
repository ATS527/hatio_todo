import 'package:hatio_todo_app/data/data_provider/user_data_provider.dart';
import 'package:hatio_todo_app/data/model/user.dart';

class UserRepository {
  final UserDataProvider _userDataProvider = UserDataProvider();

  Future<User> registerUser(String name, String email, String password) async {
    var response =
        await _userDataProvider.registerUserData(name, email, password);

    return User.fromJson(response);
  }

  Future<User> loginUser(String email, String password) async {
    var response = await _userDataProvider.loginUserData(email, password);


    return User.fromJson(response);
  }

  Future<bool> logoutUser() async {
    return await _userDataProvider.logoutUserData();
  }

  Future<User> getUser() async {
    var response = await _userDataProvider.getUserData();

    return User.fromJson(response);
  }
}
