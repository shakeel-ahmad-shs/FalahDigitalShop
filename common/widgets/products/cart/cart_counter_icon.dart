import 'package:e_commerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(CartController());

    return Stack(
      children: [
        /// Bag Icon | Cart Icon
        IconButton(
            onPressed: () => Get.to(() => CartScreen()),
            icon: const Icon(Iconsax.shopping_bag), color: UColors.light),

        /// Counter Text
        Positioned(
          right: 6.0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(color: dark ? UColors.dark : UColors.light, shape: BoxShape.circle),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(fontSizeFactor: 0.8, color: dark ? UColors.light : UColors.dark),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
