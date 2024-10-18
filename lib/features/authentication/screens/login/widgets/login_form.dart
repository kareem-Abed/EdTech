import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:edtech/features/authentication/controllers/login/login_controller.dart';
import 'package:edtech/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:edtech/features/authentication/screens/singup/singup.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';
import 'package:edtech/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          const SizedBox(height: KSizes.spaceBtwSections ,),
          TextFormField(
            controller: controller.email,
            validator: (value) => KValidator.validateEmail(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Iconsax.direct_right,
              ),
              labelText: KTexts.email,
            ),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              controller: controller.password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  KValidator.validateEmptyText(KTexts.password, value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Iconsax.password_check,
                ),
                labelText: KTexts.password,
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Obx(() => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (value) => controller.rememberMe.value =
                        !controller.rememberMe.value)),
                const Text(KTexts.rememberMe)
              ]),
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(KTexts.forgetPassword))
            ],
          ),
          const SizedBox(
            height: KSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(KTexts.signIn)),
          ),
          const SizedBox(
            height: KSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () => Get.to(() => const SingUpScreen()),
                child: const Text(KTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}
