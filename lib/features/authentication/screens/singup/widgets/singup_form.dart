import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:edtech/features/authentication/controllers/signup/signup_controller.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/constants/text_strings.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';
import 'package:edtech/utils/validators/validation.dart';

class SingUpForm extends StatelessWidget {
  const SingUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = KHelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupformKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KSizes.spaceBtwSections),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // first name and last name
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //         controller: controller.firstName,
            //         autovalidateMode: AutovalidateMode.onUserInteraction,
            //         validator: (value) =>
            //             TValidator.validateEmptyText(TTexts.firstName, value),
            //         expands: false,
            //         decoration: const InputDecoration(
            //           prefixIcon: Icon(
            //             Iconsax.user,
            //           ),
            //           labelText: TTexts.firstName,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: TSizes.spaceBtwInputFields,
            //     ),
            //     Expanded(
            //       child: TextFormField(
            //         controller: controller.lastName,
            //         autovalidateMode: AutovalidateMode.onUserInteraction,
            //         validator: (value) =>
            //             TValidator.validateEmptyText(TTexts.lastName, value),
            //         expands: false,
            //         decoration: const InputDecoration(
            //           prefixIcon: Icon(
            //             Iconsax.user,
            //           ),
            //           labelText: TTexts.lastName,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: TSizes.spaceBtwInputFields,
            // ),
            // username
            TextFormField(
              controller: controller.userName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  KValidator.validateEmptyText(KTexts.username, value),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.user_edit,
                ),
                labelText: KTexts.username,
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwInputFields,
            ),
            // email
            TextFormField(
              controller: controller.email,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => KValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.direct,
                ),
                labelText: KTexts.email,
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwInputFields,
            ),

            // phone number
            TextFormField(
              controller: controller.phoneNumber,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => KValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.call,
                ),
                labelText: KTexts.phoneNo,
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwInputFields,
            ),
            // password
            Obx(
              () => TextFormField(
                controller: controller.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => KValidator.validatePassword(value),
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
              height: KSizes.spaceBtwSections,
            ),

            Row(
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child: Obx(() => Checkbox(
                        value: controller.privacyPolicy.value,
                        onChanged: (value) => controller.privacyPolicy.value =
                            !controller.privacyPolicy.value))),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '${KTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: KTexts.privacyPolicy,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? KColors.white : KColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? KColors.white : KColors.primary,
                        ),
                  ),
                  TextSpan(
                    text: ' ${KTexts.and} ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: KTexts.privacyPolicy,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? KColors.white : KColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? KColors.white : KColors.primary,
                        ),
                  ),
                ])),
              ],
            ),
            const SizedBox(
              height: KSizes.spaceBtwSections,
            ),

            // singup button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(KTexts.createAccount)),
            ),
          ],
        ),
      ),
    );
  }
}
