// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:ecommerce_app/src/features/products/domain/product.dart';

/// Model class representing the shopping cart contents.
class WishList {
  const WishList([this.products = const []]);

  final List<ProductID> products;

  @override
  String toString() => 'WishList(items: $products)';

  @override
  bool operator ==(covariant WishList other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;
}
