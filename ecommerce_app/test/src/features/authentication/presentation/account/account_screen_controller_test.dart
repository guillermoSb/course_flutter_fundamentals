@Timeout(Duration(milliseconds: 500))
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late AccountScreenController controller;
  late MockAuthRepository authRepository;
  setUp(() {
    // Runs before every test case
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      expect(controller.state, const AsyncData<void>(null));
    });

    test(
      'signOut success',
      () async {
        // Arrange
        when(authRepository.signOut).thenAnswer((_) => Future.value());
        // Act
        expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            const AsyncData<void>(null),
          ]),
        );
        await controller.signOut();
        // Assert
        verify(authRepository.signOut).called(1);
      },
    );

    test(
      'signOut failure',
      () async {
        // Arrange
        final exception = Exception('Connection failed');
        when(authRepository.signOut).thenThrow(exception);
        // Act
        expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value.hasError, true);
              return true;
            })
          ]),
        );
        await controller.signOut();
        // Assert
        verify(authRepository.signOut).called(1);
        // expect(controller.state.hasError, true);
        // expect(controller.state,
        //     isA<AsyncError>()); // Ccheck that the state is AsyncError
      },
    );
  });
}
