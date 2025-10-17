import 'package:e_commerce/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({
    super.key,
    required this.cartItem
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// Product Image
        URoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ),
        SizedBox(width: USizes.spaceBtwItems),

        /// Brand, Name, Variation
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Brand
                UBrandTitleWithVerifyIcon(title: cartItem.brandName ?? ''),

                /// Title
                UProductTitleText(title: cartItem.title, maxLines: 1),

                /// Variation OR Attributes
                RichText(
                    text: TextSpan(children: (cartItem.selectedVariation ??{}).entries.map((e) => TextSpan(
                      children: [
                        TextSpan(text: '${e.key} ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                      ]
                    )).toList()))
              ],
            ))
      ],
    );
  }
}