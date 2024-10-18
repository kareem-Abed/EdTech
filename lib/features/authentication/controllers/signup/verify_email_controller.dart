import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:edtech/common/widgets/loaders/loaders.dart';
import 'package:edtech/common/widgets/success_screen/success_screen.dart';
import 'package:edtech/data/repositories/authentication/authentication_repositoris.dart';
import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoredirect();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      KLoaders.sucssessSnackBar(
          message:
              "يرجى التحقق من صندوق البريد الخاص بك والتحقق من بريدك الإلكتروني",
          title: 'تم إرسال البريد الإلكتروني ');
    } catch (e) {
      KLoaders.errorSnackBar(message: e.toString(), title: 'حدث خطأ');
    }
  }

  setTimerForAutoredirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(SuccessScreen(
          image: KImages.successfullyRegisterAnimation,
          title: KTexts.yourAccountCreatedSubTitle,
          subTitle: KTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            image: KImages.successfullyRegisterAnimation,
            title: KTexts.yourAccountCreatedTitle,
            subTitle: KTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
    }
  }
}
