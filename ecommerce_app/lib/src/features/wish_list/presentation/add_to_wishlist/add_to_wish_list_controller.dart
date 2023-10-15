import 'package:ecommerce_app/src/features/wish_list/application/wish_list_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToWishListController extends StateNotifier<AsyncValue<void>> {
  AddToWishListController({
    required this.wishListService,
  }) : super(const AsyncData(null));
  final WishListService wishListService;

  Future<void> addProduct(String productId) async {
    state = const AsyncLoading();
    final value =
        await AsyncValue.guard(() => wishListService.addProduct(productId));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(null);
    }
  }
}

final addToWishListControllerProvider =
    StateNotifierProvider<AddToWishListController, AsyncValue<void>>((ref) {
  return AddToWishListController(
      wishListService: ref.watch(wishListServiceProvider));
});
