import 'package:ecommerce_app/src/features/wish_list/data/remote/remote_wish_list_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeRemoteWishListRepository extends RemoteWishListRepository {
  FakeRemoteWishListRepository({this.addDelay = true});
  final _wishLists = InMemoryStore<Map<String, WishList>>({});
  final bool addDelay;
  @override
  Future<WishList> fetchWishList(String uid) async {
    await delay(addDelay);
    return _wishLists.value[uid] ?? const WishList();
  }

  @override
  Future<void> setWishList(String uid, WishList wishList) async {
    await delay(addDelay);
    final wishLists = _wishLists.value;
    wishLists[uid] = wishList;
    _wishLists.value = wishLists;
  }

  @override
  Stream<WishList> watchWishList(String uid) {
    return _wishLists.stream
        .map((wishListData) => wishListData[uid] ?? const WishList());
  }
}
