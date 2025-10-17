
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/rounded_image.dart';
import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/product_model.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/screens/product_details/product_details.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../style/shadow.dart';
import '../../button/add_to_card_button.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../favourite/favourite_icon.dart';

class UProductCardVertical extends StatelessWidget {
  const UProductCardVertical({
    super.key,
    required this.product
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: UShadow.verticalProductShadow,
            borderRadius: BorderRadius.circular(USizes.productImageRadius),
            color: dark ? UColors.darkerGrey : UColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail, Favourite Button And Discount Tag
            URoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.dark : UColors.light,
              child: Stack(
                children: [
                  /// Thumbnail
                  Center(child: URoundedImage(imageUrl: product.thumbnail, isNetworkImage: true)),

                  /// Discount Tag
                  if(salePercentage != null)
                  Positioned(
                    top: 12.0,
                    child: URoundedContainer(
                      radius: USizes.sm,
                      backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                      padding: const EdgeInsets.symmetric(horizontal: USizes.sm, vertical: USizes.xs),
                      child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: UColors.black)),
                    ),
                  ),

                  /// Favourite Button
                  Positioned(right: 0, top: 0, child: UFavouriteIcon(productId: product.id))
                ],
              ),
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),

            /// Details
            Padding(
              padding: const EdgeInsets.only(left: USizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Title
                  UProductTitleText(title: product.title, smallSize: true),
                  SizedBox(height: USizes.spaceBtwItems / 2),

                  /// Product Brand
                  UBrandTitleWithVerifyIcon(title: product.brand!.name),
                ],
              ),
            ),
            Spacer(),

            /// Product Price & Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Product Price
                Padding(padding: const EdgeInsets.only(left: USizes.sm), child: UProductPriceText(price: controller.getProductPrice(product))),

                /// Add Button
                ProductAddToCartButton(product: product)
              ],
            )
          ],
        ),
      ),
    );
  }
}




