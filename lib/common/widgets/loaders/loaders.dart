import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KLoaders {
  static bool isSnackbarActive = false;

  static hideSnackBar() {
    isSnackbarActive = false;
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }

  static void customToast({required message}) {
    if (!isSnackbarActive) {
      isSnackbarActive = true;

      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: KHelperFunctions.isDarkMode(Get.context!)
                    ? KColors.darkGrey.withOpacity(0.9)
                    : KColors.grey.withOpacity(0.9),
              ),
              child: Center(
                child: Text(
                  message,
                  style: Theme.of(Get.context!).textTheme.labelLarge,
                ),
              )),
        ),
      ));

      Future.delayed(const Duration(seconds: 3), () {
        isSnackbarActive = false;
      });
    }
  }

  static void successSnackBar(
      {required String title, message = '', duration = 3}) {
    if (!isSnackbarActive) {
      isSnackbarActive = true;
      Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: KColors.white,
        backgroundColor: KColors.primary,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration, milliseconds: 500),
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Iconsax.check,
          color: KColors.white,
        ),
      );
      Future.delayed(const Duration(seconds: 3), () {
        isSnackbarActive = false;
      });
    }
  }

  static void warningSnackBar({required String title, message = '',bool bottomPosition=true}) {
    if (!isSnackbarActive) {
      isSnackbarActive = true;

      Get.snackbar(
        title,
        message,
        isDismissible: false,
        shouldIconPulse: true,
        colorText: KColors.white,
        backgroundColor: Colors.orange.shade600,
        snackPosition: bottomPosition?SnackPosition.BOTTOM:SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: KColors.white,
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        isSnackbarActive = false;
      });
    }
  }

  static void errorSnackBar({required String title, message = ''}) {
    if (!isSnackbarActive) {
      isSnackbarActive = true;

      Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: KColors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: KColors.white,
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        isSnackbarActive = false;
      });
    }
  }
}
