import 'package:ecommerce_app/src/features/wish_list/data/remote/fake_remote_list_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class RemoteWishListRepository {
  Future<WishList> fetchWishList(String uid);
  Stream<WishList> watchWishList(String uid);
  Future<void> setWishList(String uid, WishList wishList);
}

final remoteWishListRepositoryProvider =
    Provider<RemoteWishListRepository>((ref) {
  return FakeRemoteWishListRepository();
});
