import 'package:guatappe/domain/datasources/users_datasource.dart';
import 'package:guatappe/domain/entities/user_entity.dart';
import 'package:guatappe/domain/repositories/users_repository.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';

class UserRepositoryImpl extends UsersRepository {
  final UsersDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> getUserById(String? id) {
    return dataSource.getUserById(id ?? '');
  }

  @override
  Future<void> createUser(UserModel newUser) {
    return dataSource.createUser(newUser);
  }
}
