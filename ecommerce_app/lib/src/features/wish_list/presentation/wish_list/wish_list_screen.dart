import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/wish_list/application/wish_list_service.dart';
import 'package:ecommerce_app/src/features/wish_list/domain/wish_list.dart';
import 'package:ecommerce_app/src/features/wish_list/presentation/wish_list/wish_list_item.dart';
import 'package:ecommerce_app/src/features/wish_list/presentation/wish_list/wish_list_screen_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shopping cart screen showing the items in the cart (with editable
/// quantities) and a button to checkout.
class WishListScreen extends ConsumerWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      wishListScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Wish List'.hardcoded),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final wishListValue = ref.watch(wishListProvider);
          return AsyncValueWidget<WishList>(
            value: wishListValue,
            data: (wishList) => wishList.products.isEmpty
                ? EmptyPlaceholderWidget(
                    message: 'Your Wish List is empty.'.hardcoded,
                  )
                : ResponsiveCenter(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(Sizes.p16),
                            itemBuilder: (context, index) {
                              final item = wishList.products[index];
                              return WishListItem(productId: item);
                            },
                            itemCount: wishList.products.length,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
