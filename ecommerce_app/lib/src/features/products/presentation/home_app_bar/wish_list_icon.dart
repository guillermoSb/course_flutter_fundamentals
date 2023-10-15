import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/shopping_cart_icon.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WishListIcon extends ConsumerWidget {
  static const wishListIconKey = Key('wish-list');

  const WishListIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishListItemsCount = 10;
    return Stack(
      children: [
        Center(
          child: IconButton(
            key: wishListIconKey,
            icon: const Icon(Icons.star),
            onPressed: () => context.pushNamed(AppRoute.cart.name),
          ),
        ),
        if (wishListItemsCount > 0)
          Positioned(
            top: Sizes.p4,
            right: Sizes.p4,
            child: ShoppingCartIconBadge(itemsCount: wishListItemsCount),
          ),
      ],
    );
  }
}
