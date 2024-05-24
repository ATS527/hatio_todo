import 'package:hatio_todo_app/data/data_provider/user_data_provider.dart';

class UserRepository {
  final UserDataProvider _userDataProvider;

  UserRepository({required UserDataProvider userDataProvider})
      : _userDataProvider = userDataProvider;
}
