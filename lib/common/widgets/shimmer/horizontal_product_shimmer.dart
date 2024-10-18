import 'package:flutter/material.dart';
import 'package:edtech/common/widgets/custom_shaps/containers/rounded_container.dart';
import 'package:edtech/common/widgets/layouts/grid_layout.dart';
import 'package:edtech/common/widgets/shimmer/shimmer.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KHorizontalProductShimmer extends StatelessWidget {
  const KHorizontalProductShimmer({
    super.key,
    required this.itemCount,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return TGridLayout2(
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        itemBuilder: (_, index) => KShimmerEffect(
                child: Container(
              width: 180,
              //height: 300,
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.only(bottom: KSizes.sm),
              decoration: BoxDecoration(
                color: dark
                    ? Colors.black.withOpacity(0.35)
                    : Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(KSizes.productImageRadius),
              ),
              child: Column(
                children: [
                  KRoundedContainer(
                    height: 180,
                    radius: KSizes.productImageRadius,
                    padding: const EdgeInsets.all(KSizes.sm),
                    backgroundColor: dark ? KColors.dark : KColors.grey,
                    chiled: const Stack(
                      alignment: Alignment.topCenter,
                      children: [],
                    ),
                  ),
                  const Spacer(),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: KSizes.sm,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: KSizes.sm),
                            Row(
                              children: [
                                KShimmerEffect(width: 150, hight: 8),
                              ],
                            ),
                            SizedBox(height: KSizes.sm),
                            KShimmerEffect(width: 110, hight: 8),
                            SizedBox(
                              height: KSizes.sm,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: KSizes.md, bottom: KSizes.md),
                        child: Row(
                          children: [
                            KShimmerEffect(width: 80, hight: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KShimmerEffect(width: 56, hight: 40),
                      SizedBox(
                        width: KSizes.xs,
                      ),
                      KShimmerEffect(width: 50, hight: 40),
                      SizedBox(
                        width: KSizes.xs,
                      ),
                      KShimmerEffect(width: 56, hight: 40),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            )));
  }
}
/*

   Container(
                width: 180,
                padding: const EdgeInsets.all(1),
                margin: const EdgeInsets.only(bottom: TSizes.sm),
                decoration: BoxDecoration(
                  color: dark ? TColors.darkContainer : TColors.white,
                  borderRadius:
                      BorderRadius.circular(TSizes.productImageRadius),
                ),
                child: Column(
                  children: [
                    TRoundedContainer(
                      height: 180,
                      radius: TSizes.productImageRadius,
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: dark ? TColors.dark : TColors.grey,
                      chiled: TRoundedImage(
                        imageUrl: TImages.caned,
                        applyImageRadius: true,
                        fit: BoxFit.contain,
                        backgroundColor: dark ? TColors.dark : TColors.grey,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: TSizes.sm),
                        TShimmerEffect(width: 60, hight: 8),
                        SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                      ],
                    ),
                    //const Spacer(),
                  ],
                ),
              ),
 */
