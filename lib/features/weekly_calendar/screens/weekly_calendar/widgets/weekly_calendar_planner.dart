import 'package:edtech/features/weekly_calendar/controllers/weekly_calendar_controller.dart';
import 'package:edtech/time_planer/time_planner.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklyCalendarPlanner extends StatelessWidget {
  const WeeklyCalendarPlanner({super.key, required this.viewCurrentDayOnly});
  final bool viewCurrentDayOnly;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeeklyCalendarController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final newCellWidth = (constraints.maxWidth / 7).toDouble();
        controller.updateCellWidth(newCellWidth);

        return Obx(() {
          return TimePlanner(
            viewCurrentDayOnly: viewCurrentDayOnly,
            startHour: 7,
            endHour: 21,
            use24HourFormat: false,
            setTimeOnAxis: true,
            style: TimePlannerStyle(
              backgroundColor: Colors.grey[900],
              // cellWidth: controller.cellWidth.value,
              cellHeight: 100,
              showScrollBar: true,
              dividerColor: Colors.blue,
              // horizontalTaskPadding: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              interstitialEvenColor: Colors.grey[850],
              interstitialOddColor: Colors.grey[800],
            ),
            headers: [
              TimePlannerTitle(
                title: 'السبت',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 0
                        ? Colors.blue
                        : KColors.white),
                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              TimePlannerTitle(
                title: 'الأحد',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 1
                        ? Colors.blue
                        : KColors.white),

                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              TimePlannerTitle(
                title: 'الاثنين',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 2
                        ? Colors.blue
                        : KColors.white),

                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              TimePlannerTitle(
                title: 'الثلاثاء',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 3
                        ? Colors.blue
                        : KColors.white),

                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              TimePlannerTitle(
                title: 'الأربعاء',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 4
                        ? Colors.blue
                        : KColors.white),

                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              TimePlannerTitle(
                title: 'الخميس',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 5
                        ? Colors.blue
                        : KColors.white),

                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
              TimePlannerTitle(
                title: 'الجمعة',
                titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: controller.currentDay.value == 6
                        ? Colors.blue
                        : KColors.white),

                dateStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
            ],
            // ignore: invalid_use_of_protected_member
            tasks: controller.tasks.value,
          );
        });
      },
    );
  }
}
