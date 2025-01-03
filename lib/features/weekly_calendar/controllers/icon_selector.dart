import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class IconChoicesModel {
  IconData icon;
  String name;
  int color;

  IconChoicesModel(
      {required this.icon, required this.name, required this.color});

  IconChoicesModel.fromJson(Map<String, dynamic> json)
      : icon = json['icon'],
        name = json['name'],
        color = json['color'];
}

class IconController extends GetxController {
  static IconController get instance => Get.find();

  Rx<IconData> selectedIcon = FontAwesomeIcons.briefcase.obs;
  RxString selectedName = 'عمل'.obs;
  Rx<int> selectedColor = 0xFF2196F3.obs;

  // Updated list with FontAwesome icons and color codes
  List<IconChoicesModel> iconChoices = [
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.briefcase,
      'name': 'عمل',
      'color': 0xFF2196F3 // Blue
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.solidBell,
      'name': 'استيقاظ',
      'color': 0xFFFF6347 // Amber
    }),
    IconChoicesModel(
        icon: FontAwesomeIcons.utensils,
        name: 'فطور',
        color: 0xFFFF9800 // Orange
        ),
    IconChoicesModel(
        icon: FontAwesomeIcons.laptopCode,
        name: 'المشروع',
        color: 0xFF4CAF50
        ),
    IconChoicesModel(
        icon: FontAwesomeIcons.gamepad,
        name: 'استراحة',
        color: 0xFF673AB7 // Deep Purple
        ),
    IconChoicesModel(
        icon: FontAwesomeIcons.dumbbell,
        name: 'تمرين',
        color: 0xFFE91E63 // Pink
        ),
    IconChoicesModel(
        icon: FontAwesomeIcons.bed, name: 'النوم', color: 0xFF9C27B0 // Purple
        ),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.book,
      'name': 'دراسة',
      'color': 0xFF8BC34A
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.code,
      'name': 'برمجة',
      'color': 0xFF009688 // Teal
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.school,
      'name': 'مدرسة',
      'color': 0xFFD32F2F // Red
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.cartShopping,
      'name': 'تسوق',
      'color': 0xFFFB8C00 // Deep Orange
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.toilet,
      'name': 'حمام',
      'color': 0xFFAB47BC // Purple
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.personWalking,
      'name': 'خروج',
      'color': 0xFF1976D2 // Blue
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.hospital,
      'name': 'مستشفى',
      'color': 0xFFD32F2F // Red
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.calendarDay,
      'name': 'حدث',
      'color': 0xFF009688 // Teal
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.music,
      'name': 'موسيقى',
      'color': 0xFFE91E63 // Pink
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.film,
      'name': 'سينما',
      'color': 0xFF00BCD4 // Cyan
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.lightbulb,
      'name': 'أفكار',
      'color': 0xFFFFC107 // Yellow
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.mosque,
      'name': 'صلاة',
      'color': 0xFF00796B // Teal
    }),
    IconChoicesModel.fromJson({
      'icon': FontAwesomeIcons.bullseye,
      'name': 'هدف',
      'color': 0xFFD32F2F // Red
    }),
  ];

  void changeIcon(IconData icon, String name, int color) {
    selectedIcon.value = icon;
    selectedName.value = name;
    selectedColor.value = color;
  }
}

class IconSelector extends StatelessWidget {
  final IconController iconController = Get.put(IconController());

  IconSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon Selection (Top)
        Container(
          padding: const EdgeInsets.all(KSizes.sm / 2),
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: KColors.darkModeSubCard,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(' نوع المهمة ',
                      style: Theme.of(context).textTheme.headlineSmall!),
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: KSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 64,
                            height: 50,
                            child: Icon(
                              iconController.selectedIcon.value,
                              size: 40,
                              color: Color(iconController.selectedColor.value),
                            ),
                          ),
                          Text(
                            iconController.selectedName.value,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color:
                                      Color(iconController.selectedColor.value),
                                ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: KSizes.sm),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: iconController.iconChoices.length,
                itemBuilder: (context, index) {
                  final iconChoice = iconController.iconChoices[index];
                  return InkWell(
                    onTap: () => iconController.changeIcon(
                      iconChoice.icon,
                      iconChoice.name,
                      iconChoice.color,
                    ),
                    customBorder: const CircleBorder(),
                    child: Column(
                      children: [
                        Ink(
                          width: 38,
                          child: Icon(
                            iconChoice.icon,
                            color: Color(iconChoice.color),
                          ),
                        ),
                        const SizedBox(height: KSizes.sm / 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            iconChoice.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Color(iconChoice.color),
                                    ),
                          ),
                        ),
                        // SizedBox(
                        //   height: KSizes.md,
                        //   width: 40,
                        // ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
