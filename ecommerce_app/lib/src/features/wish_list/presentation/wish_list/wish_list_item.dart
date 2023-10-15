import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/common_widgets/secondary_button.dart';
import 'package:ecommerce_app/src/features/cart/presentation/add_to_cart/add_to_cart_widget.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/wish_list/presentation/wish_list/wish_list_screen_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a shopping cart item (or loading/error UI if needed)
class WishListItem extends ConsumerWidget {
  const WishListItem({
    super.key,
    required this.productId,
  });
  final ProductID productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productProvider(productId));
    return AsyncValueWidget<Product?>(
      value: productValue,
      data: (product) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: WishListProductContents(
              product: product!,
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a shopping cart item for a given product
class WishListProductContents extends ConsumerWidget {
  const WishListProductContents({
    super.key,
    required this.product,
  });
  final Product product;

  // * Keys for testing using find.byKey()
  static Key deleteKey(int index) => Key('delete-$index');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wishListScreenControllerProvider);
    final priceFormatted =
        ref.watch(currencyFormatterProvider).format(product.price);
    return ResponsiveTwoColumnLayout(
      startFlex: 1,
      endFlex: 2,
      breakpoint: 320,
      startContent: CustomImage(imageUrl: product.imageUrl),
      spacing: Sizes.p24,
      endContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
          gapH24,
          Text(priceFormatted,
              style: Theme.of(context).textTheme.headlineSmall),
          gapH24,
          AddToCartWidget(product: product),
          gapH24,
          SecondaryButton(
            text: 'Remove from Wish List'.hardcoded,
            isLoading: state.isLoading,
            onPressed: () => ref
                .read(wishListScreenControllerProvider.notifier)
                .removeProduct(product.id),
          )
        ],
      ),
    );
  }
}
