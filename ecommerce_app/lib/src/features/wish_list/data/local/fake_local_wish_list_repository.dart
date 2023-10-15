import 'package:ecommerce_app/src/features/wish_list/data/local/local_wish_list_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeLocalWishListRepository extends LocalWishListRepository {
  final _wishList = InMemoryStore<WishList>(const WishList());

  @override
  Future<WishList> fetchWishList() => Future.value(_wishList.value);

  @override
  Stream<WishList> watchWishList() => _wishList.stream;

  @override
  Future<void> setWishList(WishList wishList) {
    _wishList.value = wishList;
    return Future.value();
  }
}
