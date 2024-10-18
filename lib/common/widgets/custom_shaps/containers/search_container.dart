// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:edtech/features/shop/controllers/search_controller.dart';
// import 'package:edtech/features/shop/screens/search/search.dart';
// import 'package:edtech/utils/constants/colors.dart';
// import 'package:edtech/utils/constants/sizes.dart';
// import 'package:edtech/utils/device/device_utility.dart';
// import 'package:edtech/utils/helpers/helper_functions.dart';
//
// class KSerchContaner2 extends StatelessWidget {
//   const KSerchContaner2({
//     super.key,
//     required this.text,
//     this.icon = Iconsax.search_normal,
//     this.showBackGround = true,
//     this.showBorder = false,
//   });
//   final String text;
//   final IconData? icon;
//   final bool showBackGround, showBorder;
//   @override
//   Widget build(BuildContext context) {
//     final darkMode = KHelperFunctions.isDarkMode(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
//       child: Container(
//         width: KDeviceUtils.getScreenWidth(context),
//         padding: const EdgeInsets.all(KSizes.md),
//         decoration: BoxDecoration(
//           color: showBackGround
//               ? darkMode
//                   ? KColors.dark
//                   : KColors.light
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
//           border: showBorder ? Border.all(color: KColors.grey) : null,
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: KColors.darkGrey,
//             ),
//             const SizedBox(width: KSizes.spaceBtwItems),
//             Text(
//               text,
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TSerchContaner extends StatelessWidget {
//   const TSerchContaner({
//     super.key,
//     this.hintText,
//     this.icon = Iconsax.search_normal,
//     this.showBackGround = true,
//     this.showBorder = false,
//     required this.gotoSerch,
//   });
//   final String? hintText;
//   final IconData? icon;
//   final bool showBackGround, showBorder, gotoSerch;
//
//   @override
//   Widget build(BuildContext context) {
//     final darkMode = KHelperFunctions.isDarkMode(context);
//     final textEditingController = TextEditingController();
//     final controller = Get.put(SearchProductsController());
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
//       child: Container(
//         width: KDeviceUtils.getScreenWidth(context),
//         padding: const EdgeInsets.all(KSizes.xs),
//         decoration: BoxDecoration(
//           color: showBackGround
//               ? darkMode
//                   ? KColors.dark
//                   : KColors.light
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
//           border: showBorder ? Border.all(color: KColors.grey) : null,
//         ),
//         child: Row(
//           children: [
//             const SizedBox(width: KSizes.spaceBtwItems),
//             GestureDetector(
//               onTap: () {
//                 String value = textEditingController.text.trim();
//                 if (value.isNotEmpty) {
//                   controller.fetchSearchProducts(value);
//                   controller.searchText.value = value;
//                   controller.serchTextcontroller.value.text = value;
//                 }
//                 Get.to(const SearchScreen());
//               },
//               child: Icon(
//                 icon,
//                 color: KColors.darkGrey,
//               ),
//             ),
//             const SizedBox(width: KSizes.spaceBtwItems),
//             Expanded(
//               child: TextFormField(
//                 controller: textEditingController,
//                 onFieldSubmitted: (value) {
//                   value = value.trim();
//                   if (value.isNotEmpty) {
//                     controller.fetchSearchProducts(value);
//                     controller.searchText.value = value;
//                     controller.serchTextcontroller.value.text = value;
//                   }
//                   Get.to(const SearchScreen());
//                 },
//                 decoration: InputDecoration(
//                   hintText: hintText,
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   disabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   hintStyle: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
