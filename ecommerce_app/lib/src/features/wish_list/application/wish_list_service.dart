import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wish_list/data/local/local_wish_list_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/data/remote/remote_wish_list_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/mutable_wish_list.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishListService {
  WishListService(this.ref);
  final Ref ref;

  Future<WishList> _fetchWishList() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref.read(remoteWishListRepositoryProvider).fetchWishList(user.uid);
    } else {
      return ref.read(localWishListRepositoryProvider).fetchWishList();
    }
  }

  Future<void> _setWishList(WishList wishList) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref
          .read(remoteWishListRepositoryProvider)
          .setWishList(user.uid, wishList);
    } else {
      return ref.read(localWishListRepositoryProvider).setWishList(wishList);
    }
  }

  Future<void> addProduct(ProductID productId) async {
    final wishList = await _fetchWishList();
    final updated = wishList.addProduct(productId);
    await _setWishList(updated);
  }

  Future<void> removeProduct(ProductID productID) async {
    final wishList = await _fetchWishList();
    final updated = wishList.removeProduct(productID);
    await _setWishList(updated);
  }
}

final wishListServiceProvider = Provider<WishListService>((ref) {
  return WishListService(ref);
});

final wishListProvider = StreamProvider<WishList>((ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    return ref.watch(localWishListRepositoryProvider).watchWishList();
  } else {
    return ref.watch(remoteWishListRepositoryProvider).watchWishList(user.uid);
  }
});

final wishListCountProvider = Provider.autoDispose<int>((ref) {
  final wishList = ref.watch(wishListProvider).value ?? const WishList();
  return wishList.products.length;
});

final productInWishListProvider =
    Provider.family.autoDispose<bool, ProductID>((ref, productID) {
  final wishList = ref.watch(wishListProvider).value ?? const WishList();
  final wishListProducts = wishList.products;
  return wishListProducts.contains(productID);
});
