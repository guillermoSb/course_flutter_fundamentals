import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/presentation/add_to_cart/add_to_cart_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('AddToCartController', () {
    setUpAll(() {
      registerFallbackValue(const Item(productId: 'abc', quantity: 1));
    });
    test('updateQuantity(1) sets the new value', () {
      // arrange
      final cartService = MockCartService();
      final addToCartController = AddToCartController(cartService: cartService);
      // act
      addToCartController.updateQuantity(1);
      // assert
      expect(addToCartController.debugState, const AsyncData(1));
    });

    test('addItem() resets state to 1 if there is no error.', () async {
      // arrange
      final cartService = MockCartService();
      final addToCartController = AddToCartController(cartService: cartService);
      when(() => cartService.addItem(any())).thenAnswer((_) => Future.value());
      // act
      await addToCartController.addItem('abc');
      // assert
      expect(addToCartController.debugState, const AsyncData(1));
    });
    test('addItem() state is error if the service does not work.', () async {
      // arrange
      final cartService = MockCartService();
      final exception = Exception('Connection Failed');
      when(() => cartService.addItem(any())).thenThrow(exception);
      final addToCartController = AddToCartController(cartService: cartService);
      // act
      await addToCartController.addItem('abc');
      // assert
      expect(addToCartController.debugState,
          predicate<AsyncValue<int>>((state) {
        expect(state.hasError, true);
        return true;
      }));
    });
  });
}
