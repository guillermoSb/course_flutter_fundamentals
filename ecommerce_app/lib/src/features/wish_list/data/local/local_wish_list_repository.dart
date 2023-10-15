import 'package:ecommerce_app/src/features/wish_list/data/local/fake_local_wish_list_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LocalWishListRepository {
  Future<WishList> fetchWishList();
  Stream<WishList> watchWishList();
  Future<void> setWishList(WishList wishList);
}

final localWishListRepositoryProvider =
    Provider<LocalWishListRepository>((ref) {
  throw UnimplementedError();
});
