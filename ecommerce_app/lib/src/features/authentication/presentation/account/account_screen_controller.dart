// ignore: depend_on_referenced_packages
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  FakeAuthRepository authRepository;

  AccountScreenController({required this.authRepository})
      : super(const AsyncData(null));
  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signOut);
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
