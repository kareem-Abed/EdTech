import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:edtech/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();

  RxInt curruntPageIndex = 0.obs;

  void updatePageIndicator(index) => curruntPageIndex.value = index;

  void dotNavigationClick(index) {
    curruntPageIndex.value = index;
    pageController.animateToPage(curruntPageIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void nextPage() {
    if (curruntPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(() => const LoginScreen());
    } else {
      curruntPageIndex.value++;
      pageController.animateToPage(curruntPageIndex.value,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  void skipPage() {
    curruntPageIndex.value = 2;
    pageController.animateToPage(curruntPageIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
