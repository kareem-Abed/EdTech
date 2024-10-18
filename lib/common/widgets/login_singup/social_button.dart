import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/features/authentication/controllers/login/login_controller.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/image_strings.dart';

class KSocialButtons extends StatelessWidget {
  const KSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return OutlinedButton(
      onPressed: () => controller.signInWithGoogle(),
      child: const CircleAvatar(
        radius: 13,
        backgroundColor: KColors.white,
        child: Image(
          //width: TSizes.iconMd,
          //height: TSizes.iconMd,
          image: AssetImage(KImages.google),
        ),
      ),
    );
/*
    InkWell(
        onTap: () => controller.signInWithGoogle(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(11),
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: TColors.white,
            child: Image(
              width: TSizes.iconMd,
              height: TSizes.iconMd,
              image: AssetImage(TImages.google),
            ),
          ),
        ));
        */
        
  }
}
