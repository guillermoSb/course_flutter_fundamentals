import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/common_widgets/secondary_button.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wish_list/application/wish_list_service.dart';
import 'package:ecommerce_app/src/features/wish_list/presentation/add_to_wishlist/add_to_wish_list_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToWishListWidget extends ConsumerWidget {
  final Product product;
  const AddToWishListWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addToWishListControllerProvider);
    ref.listen<AsyncValue<void>>(addToWishListControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    return SecondaryButton(
        isLoading: controller.isLoading,
        text: ref.watch(productInWishListProvider(product.id))
            ? 'Already on your Wish List'.hardcoded
            : 'Add to Wish List'.hardcoded,
        onPressed: ref.watch(productInWishListProvider(product.id))
            ? null
            : () {
                ref
                    .read(addToWishListControllerProvider.notifier)
                    .addProduct(product.id);
              });
  }
}
