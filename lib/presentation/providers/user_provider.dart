import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/domain/entities/user_entity.dart';
import 'package:guatappe/presentation/providers/providers.dart';

final userDataProvider = StateProvider((ref) async {
  final authUser = ref.watch(authStateProvider).value;
  if (authUser == null) await authUser?.reload();
  final UserEntity userFirestore =
      await ref.watch(userRepositoryProvider).getUserById(authUser?.uid);
  return userFirestore;
});
