import 'package:edtech/features/weekly_calendar/controllers/weekly_calendar_controller.dart';
import 'package:edtech/features/weekly_calendar/screens/weekly_calendar/widgets/weekly_calendar_add_update.dart';
import 'package:edtech/features/weekly_calendar/screens/weekly_calendar/widgets/weekly_calendar_planner.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/utils/constants/sizes.dart';

class WeeklyCalendarScreen extends StatelessWidget {
  const WeeklyCalendarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final WeeklyCalendarController controller =
        Get.put(WeeklyCalendarController());
    final List<String> daysOfWeek = [
      'سبت',
      'حد',
      'تنين',
      'تلات',
      'اربع',
      'خميس',
      'جمعة'
    ];

    return Scaffold(
      backgroundColor: KColors.darkModeBackground,
      body: SafeArea(
        child: Container(
            // margin: const EdgeInsets.all(KSizes.sm),
            child: Column(
              children: [
                Row(
                  children: daysOfWeek.map((day) {
                    int index = daysOfWeek.indexOf(day);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.changeCurrentDay(index);
                        },
                        child: Obx(
                          () => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: 40,
                            decoration: BoxDecoration(
                              color: controller.currentDay.value == index
                                  ? KColors.primary
                                  : KColors.darkModeCard,
                              border: Border.all(
                                color: KColors.darkModeCardBorder,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(KSizes.borderRadius),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: controller.currentDay.value == index
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: KSizes.sm),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: KColors.darkModeCard,
                          border: Border.all(
                              color: KColors.darkModeCardBorder, width: 1),
                          borderRadius:
                              BorderRadius.circular(KSizes.borderRadius),
                        ),
                        child: const WeeklyCalendarPlanner(
                            viewCurrentDayOnly: true))),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            scrollControlDisabledMaxHeightRatio: 0.9,

            context: context,
            isScrollControlled: false,
            // showDragHandle: true,
            builder: (BuildContext context) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 5,
                  ),
                  child: SingleChildScrollView(child: AddTaskForm()),
                ),
              );
            },
          );
        },
        backgroundColor: KColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
