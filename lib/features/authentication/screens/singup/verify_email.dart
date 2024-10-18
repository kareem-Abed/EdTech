// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/data/repositories/authentication/authentication_repositoris.dart';
import 'package:edtech/features/authentication/controllers/signup/verify_email_controller.dart';

import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear),
            onPressed: () =>AuthenticationRepository.instance.logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              //image

              Image(
                width: KHelperFunctions.screenWidth() * 0.6,
                image: const AssetImage(KImages.deliveredEmailIllustration),
              ),
              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),
              //Title
              Text(
                KTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              //email
              Text(email ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              //subtitle
              Text(KTexts.confirmEmailSubTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),
              //buttons

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                 
                  onPressed: ()=>controller.checkEmailVerificationStatus(),
                  child: const Text(KTexts.tContinue),
                ),
              ),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: ()=>controller.sendEmailVerification(),
                  child: const Text(KTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
