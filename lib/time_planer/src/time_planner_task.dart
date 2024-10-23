import 'package:edtech/features/weekly_calendar/controllers/weekly_calendar_controller.dart';
import 'package:edtech/time_planer/src/time_planner.dart';
import 'package:edtech/time_planer/src/time_planner_date_time.dart';
import 'package:edtech/time_planer/src/config/global_config.dart' as config;
import 'package:edtech/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/utils/constants/colors.dart';

import '../../utils/theme/widget_themes/text_theme.dart';

/// Widget that show on time planner as the tasks
class TimePlannerTask extends StatelessWidget {
  final IconData icon;
  final String title;
  //--------------------------------------------------------------------------------
  /// Minutes duration of task or object
  final int minutesDuration;
  final int? iconIndex;

  /// Days duration of task or object, default is 1
  final int? daysDuration;

  /// When this task will be happen
  final TimePlannerDateTime dateTime;

  /// Background color of task
  final Color? color;

  /// This will be happen when user tap on task, for example show a dialog or navigate to other page
  final Function? onTap;

  /// Show this child on the task
  ///
  /// Typically an [Text].
  // final Widget? child;

  /// parameter to set space from left, to set it: config.cellWidth! * dateTime.day.toDouble()
  final double? leftSpace;

  /// parameter to set width of task, to set it: (config.cellWidth!.toDouble() * (daysDuration ?? 1)) -config.horizontalTaskPadding!
  final double? widthTask;

  Map<String, dynamic> toJson() {
    return {
      'color': color?.value,
      'iconIndex': iconIndex,
      'title': title,
      'dateTime': {
        'day': dateTime.day,
        'hour': dateTime.hour,
        'minutes': dateTime.minutes,
      },
      'minutesDuration': minutesDuration,
      'daysDuration': daysDuration,
    };
  }

  /// Widget that show on time planner as the tasks
  const TimePlannerTask({
    Key? key,
    required this.minutesDuration,
    required this.dateTime,
    this.daysDuration,
    this.color,
    this.onTap,
    // this.child,
    this.leftSpace,
    this.widthTask,
    required this.icon,
    required this.title,
    this.iconIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final screenWidth = MediaQuery.of(context).size.width;
      final controller = Get.put(WeeklyCalendarController());
      final adjustedScreenWidth =
          // screenWidth - (controller.showAddTask.value ? 486 : 134);
          screenWidth - 75;

      final calculatedWidthTask = controller.showFullWidthTask.value
          ? adjustedScreenWidth
          : ((adjustedScreenWidth / config.totalDays) * (daysDuration ?? 1) -
              config.horizontalTaskPadding!);

      return Positioned(
        top: ((config.cellHeight! * (dateTime.hour - config.startHour)) +
                ((dateTime.minutes * config.cellHeight!) / 60))
            .toDouble(),
        left: controller.showFullWidthTask.value
            ? 4.0
            : (((adjustedScreenWidth) / config.totalDays) *
                    dateTime.day.toDouble() +
                (leftSpace ?? 0.0)),
        child: SizedBox(
          width: calculatedWidthTask,
          child: Padding(
            padding:
                EdgeInsets.only(left: config.horizontalTaskPadding!.toDouble()),


            child: Material(
              elevation: 3,
              borderRadius: config.borderRadius,
              child: InkWell(
                onTap: onTap as void Function()? ?? () {},
                child: Container(
                  height: ((minutesDuration.toDouble() * config.cellHeight!) /
                      60), // 60 minutes
                  width: calculatedWidthTask,
                  decoration: BoxDecoration(
                    borderRadius: config.borderRadius,
                    color: KColors.darkModeSubCard,
                    border: Border.all(
                      color: KColors.darkModeCardBorder,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: color ?? Colors.white,
                        ),
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            KSizes.sm / 2,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                'محاضرة',
                                                style: KTextTheme
                                                    .darkTextTheme.bodySmall!
                                                    .copyWith(
                                                  color: KColors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '8:30AM',
                                                style: KTextTheme
                                                    .darkTextTheme.titleMedium!
                                                    .copyWith(
                                                  color: color ?? Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                'لمدة 3h  ',
                                                style: KTextTheme
                                                    .darkTextTheme.bodySmall!
                                                    .copyWith(
                                                  color: KColors.white
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.timeline,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      'نظم تشغيل',
                                                      style: KTextTheme
                                                          .darkTextTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                        color: KColors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'د. محمد علي',
                                                    style: KTextTheme
                                                        .darkTextTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                      color: KColors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'القاعة الرئيسية',
                                                    style: KTextTheme
                                                        .darkTextTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                      color: KColors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: color ?? Colors.white,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'بعد 5 ساعات و 30 دقيقة من الآن',
                                          style: KTextTheme
                                              .darkTextTheme.titleLarge!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
