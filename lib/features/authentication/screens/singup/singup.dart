// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:edtech/common/widgets/login_singup/form_divider.dart';
import 'package:edtech/common/widgets/login_singup/social_button.dart';

import 'package:edtech/features/authentication/screens/singup/widgets/singup_form.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(KTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),

              //form
              SingUpForm(),

              KFormDivider(
                dividertext: KTexts.orSignUpWith.capitalize!,
              ),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: KSocialButtons())
            ],
          ),
        ),
      ),
    );
  }
}
