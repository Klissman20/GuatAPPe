import 'package:guatappe/domain/entities/user_entity.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';

class UserMapper {
  static UserEntity movieDBToEntity(UserModel userfb) => UserEntity(
      name: userfb.name,
      lastName: userfb.lastName,
      email: userfb.email,
      gender: userfb.gender,
      country: userfb.country,
      phone: userfb.phone);
}
