import 'package:flutter/material.dart';
import 'package:edtech/common/widgets/custom_shaps/containers/rounded_container.dart';
import 'package:edtech/common/widgets/images/rounded_image.dart';
import 'package:edtech/common/widgets/layouts/grid_layout.dart';
import 'package:edtech/common/widgets/shimmer/shimmer.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KCategoriesShimmer extends StatelessWidget {
  const KCategoriesShimmer({
    super.key,
    required this.itemCount,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return TGridLayout2(
        itemCount: itemCount,
        itemBuilder: (_, index) => KShimmerEffect(
              child: Container(
                width: 180,
                padding: const EdgeInsets.all(1),
                margin: const EdgeInsets.only(bottom: KSizes.sm),
                decoration: BoxDecoration(
                  color: dark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.3),
                  borderRadius:
                      BorderRadius.circular(KSizes.productImageRadius),
                ),
                child: Column(
                  children: [
                    KRoundedContainer(
                      height: 180,
                      width: double.infinity,
                      radius: KSizes.productImageRadius,
                      padding: const EdgeInsets.all(KSizes.sm),
                      backgroundColor: dark ? KColors.dark : KColors.grey,
                      chiled: KRoundedImage(
                        imageUrl: KImages.caned,
                        isNetworkImage: false,
                        applyImageRadius: true,
                        width: 180,
                        fit: BoxFit.contain,
                        backgroundColor: dark ? KColors.dark : KColors.grey,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: KSizes.sm),
                        KShimmerEffect(width: 60, hight: 8),
                        SizedBox(
                          height: KSizes.spaceBtwItems / 2,
                        ),
                      ],
                    ),
                    //const Spacer(),
                  ],
                ),
              ),
            ));
  }
}
