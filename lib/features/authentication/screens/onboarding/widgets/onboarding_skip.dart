import 'package:flutter/material.dart';
import 'package:edtech/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';
import 'package:edtech/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: KDeviceUtils.getAppBarHeight(),
      right: KSizes.defaultSpace,
      child: TextButton(
        onPressed: ()=>OnBoardingController.instance.skipPage(),
        child: const Text(KTexts.skip),
      ),
    );
  }
}
