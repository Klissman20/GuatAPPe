import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guatappe/domain/datasources/users_datasource.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';

class UserDataSourceImpl extends UsersDataSource {
  final FirebaseFirestore firebaseFirestore;

  UserDataSourceImpl(this.firebaseFirestore);

  @override
  Future<UserModel> getUserById(String id) async {
    final userFirestore =
        await firebaseFirestore.collection('users').doc(id).get();
    if (userFirestore.exists) {
      final userData = userFirestore.data();
      return UserModel(
          id: id,
          name: userData!['name'],
          lastName: userData['lastName'],
          email: userData['email'],
          gender: userData['gender'],
          country: userData['country'],
          phone: userData['phone']);
    }
    throw UnimplementedError();
  }

  @override
  Future<void> createUser(UserModel newUser) async {
    //final docRef =
    await firebaseFirestore
        .collection('users')
        .doc(newUser.id)
        .set(newUser.toJson());
  }
}
