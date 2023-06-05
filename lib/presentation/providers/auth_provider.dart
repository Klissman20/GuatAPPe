import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guatappe/presentation/providers/firebase_provider.dart';

final authStateProvider = StateProvider<User?>((ref) {
  return ref.read(firebaseAuthProvider).currentUser;
});
