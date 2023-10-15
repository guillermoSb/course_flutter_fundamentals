import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';

extension MutableWishList on WishList {
  WishList addProduct(ProductID productId) {
    final copy = List<ProductID>.from(products);
    if (copy.contains(productId)) return WishList(copy);
    copy.add(productId);
    return WishList(copy);
  }

  WishList removeProduct(ProductID productId) {
    final copy = List<ProductID>.from(products);
    copy.remove(productId);
    return WishList(copy);
  }
}
