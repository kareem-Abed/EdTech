
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/common/widgets/loaders/loaders.dart';
import 'package:edtech/data/repositories/authentication/authentication_repositoris.dart';
import 'package:edtech/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/helpers/network_manager.dart';
import 'package:edtech/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  sendPasswordResetEmail() async {
    try {
           KFullScreenLoader.openLoaderDialog(
          'جاري معالجة طلبك', KImages.docerAnimation);

      final iaConnected = await NetworkManager.instance.isConnected();
      if (!iaConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }
      if (!forgetPasswordFormKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      KFullScreenLoader.stopLoading();
      KLoaders.sucssessSnackBar(
          title: 'تم إرسال البريد',
          message: 'تم إرسال البريد الإلكتروني لتغير كلمة السر بنجاح');
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: 'خطاء', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      KFullScreenLoader.openLoaderDialog(
          'جاري معالجة طلبك', KImages.docerAnimation);

      final iaConnected = await NetworkManager.instance.isConnected();
      if (!iaConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }
    
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      KFullScreenLoader.stopLoading();

      KLoaders.sucssessSnackBar(
          title: 'تم إرسال البريد',
          message: 'تم إرسال البريد الإلكتروني لتغير كلمة السر بنجاح');
  
    } catch (e) {
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: 'خطاء', message: e.toString());
    }
  }
}
