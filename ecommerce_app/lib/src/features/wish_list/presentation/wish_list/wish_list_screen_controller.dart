import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wish_list/application/wish_list_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishListScreenController extends StateNotifier<AsyncValue<void>> {
  WishListScreenController({required this.wishListService})
      : super(const AsyncData(null));
  final WishListService wishListService;

  Future<void> removeProduct(ProductID productId) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => wishListService.removeProduct(productId));
  }
}

final wishListScreenControllerProvider =
    StateNotifierProvider<WishListScreenController, AsyncValue<void>>((ref) {
  return WishListScreenController(
    wishListService: ref.watch(wishListServiceProvider),
  );
});
