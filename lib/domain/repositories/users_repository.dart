import 'package:guatappe/domain/entities/user_entity.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';

abstract class UsersRepository {
  Future<UserEntity> getUserById(String id);

  Future<void> createUser(UserModel newUser);
}
