// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x).toList(),
    };
  }

  factory WishList.fromMap(Map<String, dynamic> map) {
    return WishList(
      List<ProductID>.from(map['products'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WishList.fromJson(String source) =>
      WishList.fromMap(json.decode(source) as Map<String, dynamic>);
}
