// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:edtech/common/styles/spacing_styles.dart';
import 'package:edtech/common/widgets/login_singup/form_divider.dart';
import 'package:edtech/common/widgets/login_singup/social_button.dart';
import 'package:edtech/features/authentication/screens/login/widgets/login_form.dart';
import 'package:edtech/features/authentication/screens/login/widgets/login_header.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: KSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              LoginHeader(),
              LoginForm(),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              KFormDivider(
                dividertext: KTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              SizedBox(width: double.infinity, child: KSocialButtons()),
            ],
          ),
        ),
      ),
    );
  }
}
