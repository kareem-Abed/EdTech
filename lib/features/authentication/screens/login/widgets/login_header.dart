import 'package:flutter/material.dart';
// import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';
// import 'package:edtech/utils/helpers/helper_functions.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image(
        //    height: 150,
        //   //fit: BoxFit.fill,
        //   image:
        //       AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        // ),
        CircleAvatar(
          radius: 54,
          // backgroundImage:
          //     AssetImage(dark ? KImages.lightAppLogo : KImages.darkAppLogo),
          backgroundColor: Colors.transparent,
        ),

        Text(
          KTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: KSizes.sm,
        ),
        Text(
          KTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
