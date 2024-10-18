import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:edtech/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: KSizes.defaultSpace,
      bottom: KDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: KColors.primary,
          ),
          child: const Icon(
            Iconsax.arrow_right_3,
          )),
    );
  }
}
