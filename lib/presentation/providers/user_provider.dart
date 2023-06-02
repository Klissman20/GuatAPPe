import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';
import 'package:guatappe/presentation/providers/authenticacion_provider.dart';
import 'package:guatappe/presentation/providers/user_repository_provider.dart';

final userDataProvider = StateProvider((ref) async {
  final authUser = ref.watch(authStateProvider);
  final UserModel userFirestore =
      await ref.watch(userRepositoryProvider).getUserById(authUser!.uid);
  return userFirestore;
});
