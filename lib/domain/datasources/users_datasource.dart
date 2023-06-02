import 'package:guatappe/infrastructure/models/user_model.dart';

abstract class UsersDataSource {
  Future<UserModel> getUserById(String id);

  Future<void> createUser(UserModel newUser);
}
