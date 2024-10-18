import 'package:flutter/material.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KVerticalImageText extends StatelessWidget {
  const KVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor ,
    this.backgroundColor,
    this.ontap,
  });

  final String image, title;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    final darkMode = KHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(right: KSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
                width: 130,
                height: 100,
                decoration: BoxDecoration(
                  color: backgroundColor ??
                      (darkMode ? KColors.dark : KColors.light),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        fit: BoxFit.cover,
                        // color: darkMode ? TColors.light : TColors.dark,
                        width: 90,
                        height: 70,
                        image: AssetImage(image),
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems / 4),
                    SizedBox(
                      width: 90,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: textColor??(darkMode ? KColors.light : KColors.dark),
                            ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
