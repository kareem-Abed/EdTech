import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:edtech/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:edtech/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:edtech/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:edtech/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:edtech/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:edtech/utils/constants/image_strings.dart';

import 'package:edtech/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            reverse: true,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  title: KTexts.onBoardingSubTitle1,
                  subTitle: KTexts.onBoardingTitle1,
                  image: KImages.onBoardingImage1),
              OnBoardingPage(
                  title: KTexts.onBoardingSubTitle2,
                  subTitle: KTexts.onBoardingTitle2,
                  image: KImages.onBoardingImage2),
              OnBoardingPage(
                  title: KTexts.onBoardingSubTitle3,
                  subTitle: KTexts.onBoardingTitle3,
                  image: KImages.onBoardingImage3),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
