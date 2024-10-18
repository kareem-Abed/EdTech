// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// import 'package:pinput/pinput.dart';
// import 'package:edtech/utils/constants/colors.dart';

// import 'package:edtech/utils/constants/sizes.dart';
// import 'package:edtech/utils/helpers/helper_functions.dart';

// class PhoneOtpScreen extends StatelessWidget {
//   const PhoneOtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final controller = LoginController.instance;
//     final isdark = THelperFunctions.isDarkMode(context);
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

//               Directionality(
//                 textDirection: TextDirection.ltr,
//                 child: Pinput(
//                   length: 6,
//                   defaultPinTheme: PinTheme(
//                     width: 56,
//                     height: 56,
//                     textStyle: TextStyle(
//                         fontSize: 20,
//                         color: isdark ? Colors.white : Colors.black),
//                     decoration: BoxDecoration(
//                       color: isdark ? TColors.darkContainer : TColors.grey,
//                       border: Border.all(
//                           color: isdark ? TColors.darkGrey : Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   focusedPinTheme: PinTheme(
//                     width: 70,
//                     height: 62,
//                     textStyle: TextStyle(
//                         fontSize: 22,
//                         color: isdark ? Colors.white : Colors.black),
//                     decoration: BoxDecoration(
//                       color: isdark
//                           ? TColors.darkContainer
//                           : TColors.lightContainer,
//                       border: Border.all(color: TColors.primary),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   submittedPinTheme: PinTheme(
//                     width: 56,
//                     height: 56,
//                     textStyle: TextStyle(
//                         fontSize: 20,
//                         color: isdark ? Colors.white : Colors.black),
//                     decoration: BoxDecoration(
//                       color: isdark ? TColors.darkContainer : TColors.grey,
//                       border: Border.all(
//                           color: isdark ? TColors.darkGrey : Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   showCursor: true,
//                   onCompleted: (pin) => print(pin),
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwSections),
//               //button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
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
