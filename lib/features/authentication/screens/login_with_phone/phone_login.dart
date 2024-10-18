// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:edtech/features/authentication/screens/login_with_phone/phone_otp.dart';

// import 'package:edtech/utils/constants/sizes.dart';
// import 'package:edtech/utils/constants/text_strings.dart';
// import 'package:edtech/utils/validators/validation.dart';

// class PhoneLoginScreen extends StatelessWidget {
//   const PhoneLoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final controller = LoginController.instance;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //heading
//               Text('التسجيل برقم الهاتف',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.headlineMedium),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               Text(
//                   'تسجيل الدخول باستخدام رقم الهاتف يعتمد على إرسال رسالة نصية قصيرة تحتوي على رمز التحقق إلى رقم الهاتف المدخل من قبل المستخدم. ',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.labelMedium),
//               const SizedBox(height: TSizes.spaceBtwSections * 2),

//               //text filed
//               Form(
//                 // key: controller.phoneFormKey,
//                 child: TextFormField(
//                   // controller: controller.phone,
//                   validator: (value) => TValidator.validatePhoneNumber(value),
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.phoneNo,
//                     prefixIcon: Icon(Iconsax.direct_right),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwSections),
//               //button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.to(() => PhoneOtpScreen());
//                   },
//                   child: const Text('ارسال رمز التحقق'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
