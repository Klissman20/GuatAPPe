import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/presentation/providers/providers.dart';

final initialLoadingProvider = Provider((ref) {
  var step = ref.watch(userCurrentLocationProvider).latitude == 0;

  if (step) return true;

  return false;
});
