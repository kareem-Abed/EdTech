import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edtech/features/authentication/controllers/user_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:edtech/common/widgets/loaders/loaders.dart';
import 'package:edtech/data/repositories/authentication/authentication_repositoris.dart';

import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/helpers/network_manager.dart';
import 'package:edtech/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorige = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  // final phone = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;
  final rememberMe = false.obs;

  final userController = Get.put(UserController());
  @override
  void onInit() {
    if (localStorige.read('REMEMBER_ME_EMAIL') != null) {
      email.text = localStorige.read('REMEMBER_ME_EMAIL');
      password.text = localStorige.read('REMEMBER_ME_PASSWORD');
      rememberMe.value = true;
    }
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      KFullScreenLoader.openLoaderDialog(
          "جاري تسجيل دخولك...", KImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorige.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorige.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // final userCredential = await AuthenticationRepository.instance
      //     .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      //
      // ignore: no_leading_underscores_for_local_identifiers
      final FirebaseFirestore _db = FirebaseFirestore.instance;
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      String? userId = AuthenticationRepository.instance.authUser?.uid;
      DocumentReference docRef = _db.collection('Users').doc(userId);
      await docRef.update({'FCMToken': token});
      //
      KFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: 'خطاء ', message: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      KFullScreenLoader.openLoaderDialog(
          "جاري تسجيل دخولك...", KImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredential);

      KFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      KFullScreenLoader.stopLoading();

      KLoaders.errorSnackBar(title: 'خطاء ', message: e.toString());
    }
  }
}
