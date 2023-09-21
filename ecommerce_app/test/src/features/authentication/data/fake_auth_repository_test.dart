import 'dart:math';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = '1234';
  final testUser =
      AppUser(uid: testEmail.split('').reversed.join(), email: testEmail);
  FakeAuthRepository makeAuthRepository() =>
      FakeAuthRepository(addDelay: false);
  group(
    "FakeAuthRepository",
    () {
      test(
        "currentUser is null",
        () {
          final authRepository = makeAuthRepository();
          addTearDown(() => authRepository.dispose);
          expect(authRepository.currentUser, null);
          expect(authRepository.authStateChanges(), emits(null));
        },
      );
      test(
        "currentUser is not null after signIn",
        () async {
          final authRepository = makeAuthRepository();
          await authRepository.signInWithEmailAndPassword(
              testEmail, testPassword);
          addTearDown(() => authRepository.dispose);
          expect(authRepository.currentUser, testUser);
          expect(authRepository.authStateChanges(), emits(testUser));
        },
      );
      test(
        "currentUser is not null after register",
        () async {
          final authRepository = makeAuthRepository();
          await authRepository.signUpWithEmailAndPassword(
              testEmail, testPassword);
          addTearDown(() => authRepository.dispose);
          expect(authRepository.currentUser, testUser);
          expect(authRepository.authStateChanges(), emits(testUser));
        },
      );

      test(
        "currentUser is null after sign out",
        () async {
          final authRepository = makeAuthRepository();
          await authRepository.signInWithEmailAndPassword(
              testEmail, testPassword);
          addTearDown(() => authRepository.dispose);
          expect(authRepository.authStateChanges(), emits(testUser));
          await authRepository.signOut();
          expect(authRepository.currentUser, null);
          expect(authRepository.authStateChanges(), emits(null));
        },
      );

      test(
        "signIn after dispose throws exception",
        () async {
          final authRepository = makeAuthRepository();
          authRepository.dispose();

          addTearDown(() => authRepository.dispose);
          expect(
              () => authRepository.signInWithEmailAndPassword(
                  testEmail, testPassword),
              throwsStateError);
        },
      );
    },
  );
}
