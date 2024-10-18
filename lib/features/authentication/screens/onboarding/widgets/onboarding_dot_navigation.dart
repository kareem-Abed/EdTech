import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:edtech/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/device/device_utility.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final controller = OnBoardingController.instance;
    final dark =KHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: KDeviceUtils.getBottomNavigationBarHeight()+25,
      left:KSizes.defaultSpace,
      
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SmoothPageIndicator(
          
            controller:controller.pageController,
            count:3,
            onDotClicked: controller.dotNavigationClick,
               effect:   ExpandingDotsEffect(
                
                activeDotColor: dark?KColors.light:KColors.dark,dotHeight: 6),
            ),
      ),
    );
  }
}
