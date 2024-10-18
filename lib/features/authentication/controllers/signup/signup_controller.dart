import 'package:edtech/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/common/widgets/loaders/loaders.dart';
import 'package:edtech/data/repositories/authentication/authentication_repositoris.dart';
import 'package:edtech/data/repositories/user/user_repositoris.dart';

import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/helpers/network_manager.dart';
import 'package:edtech/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  // final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  // final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
  void signup() async {
    try {
      KFullScreenLoader.openLoaderDialog(
          "نحن نقوم بمعالجة معلوماتك...", KImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      if (!signupformKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        KFullScreenLoader.stopLoading();
        KLoaders.warningSnackBar(
            title: 'أقبل سياسة الخصوصية',
            message: 'للمتابعة يجب عليك قبول سياسة الخصوصية');
        return;
      }
//
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      //
      final newUser = UserModel(
          id: userCredential.user!.uid,
          userName: userName.text.trim(),
          email: email.text.trim(),
          // firstName: firstName.text.trim(),
          // lastName: lastName.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
          status: 'waiting',
          storeName: '',
          address: '');
      //
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      //
      // TFullScreenLoader.stopLoading();
      KLoaders.sucssessSnackBar(
          title: 'تهانينا', message: "لقد تم إنشاء حسابك! ");
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      KFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
      //Get.to(() => const NavigationMenu());
      // Get.to(() =>  VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(
        title: 'حدث خطأ',
        message: e.toString(),
      );
    }
  }
}
