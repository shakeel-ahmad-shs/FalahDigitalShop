import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/circular_icon.dart';

class UProductQuantityWithAddRemove extends StatelessWidget {
  const UProductQuantityWithAddRemove({
    super.key,
    required this.quantity,
    this.add,
    this.remove
  });

  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// Decrement Button
        UCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: USizes.iconSm,
          color: dark ? UColors.white : UColors.black,
          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
          onPressed: remove,
        ),
        SizedBox(width: USizes.spaceBtwItems),

        /// Counter Text
        Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall
        ),
        SizedBox(width: USizes.spaceBtwItems),

        /// Increment Button
        UCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: USizes.iconSm,
          color: UColors.white,
          backgroundColor: UColors.primary,
          onPressed: add,
        )
      ],
    );
  }
}