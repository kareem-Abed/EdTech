
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/common/widgets/loaders/animation_loader.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KFullScreenLoader {
  static void openLoaderDialog(String text, String anumation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: KHelperFunctions.isDarkMode(Get.context!)
              ? KColors.black
              : KColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              KAnimationLoaderWidget(
                animation: anumation,
                text: text,
              ),
            ],
          ),
        ),
      ),
    );
  }
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
