import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:edtech/common/widgets/loaders/loaders.dart';
import 'package:edtech/features/weekly_calendar/controllers/icon_selector.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/time_planer/time_planner.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:windows_notification/notification_message.dart';
// import 'package:windows_notification/windows_notification.dart';

class WeeklyCalendarController extends GetxController {
  //--------> Timer Variables <--------\\

  /// Timer to update the time every minute
  Timer? timer;
  var currentHour = DateTime.now().hour.obs;
  var currentMinute = DateTime.now().minute.obs;

  //--------> Controller Variables <--------\\
  final IconController colorController = Get.put(IconController());
  final box = GetStorage();

  //--------> Form Variables <--------\\
  final formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController().obs;
  // final taskDescriptionController = TextEditingController().obs;
  //--------> Task Variables <--------\\
  var selectedStartTime = TimeOfDay.now().obs;
  RxDouble duration = 60.0.obs;
  RxInt daysDuration = 0.obs;

  var tasks = <TimePlannerTask>[].obs;
  RxInt taskUpdateIndex = 0.obs;
  List<Map<String, dynamic>> monthlySessions = [];
  //--------> UI Variables <--------\\
  RxBool showAddTask = false.obs;
  RxBool showFullWidthTask = true.obs;
  RxBool showUpdateTask = false.obs;
  var cellWidth = 0.obs;
  final daysOfWeek = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];
  RxInt currentDay = 0.obs;
  var selectedDays = List<bool>.filled(7, false).obs;

  //-----------------------------> Initialization Functions <-----------------------------------\\
  @override
  void onInit() {
    // clearAllTasks();
    getCurrentDay();
    loadTasksFromStorage();
    updateTime();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkAndUpdateTime();
    });

    super.onInit();
  }

  @override
  void onClose() {
    taskNameController.value.dispose();
    timer?.cancel();
    super.onClose();
  }

  Future<String> getLocalImagePath(String assetPath) async {
    final supportDir = await getApplicationSupportDirectory();
    final byteData = await rootBundle.load(assetPath);
    final file = File('${supportDir.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file.path;
  }

  void scheduleNotification({
    required String title,
    required String body,
  }) async {
    // final winNotifyPlugin = WindowsNotification(
    //   applicationId: "Second Brain",
    // );
    // const String url = "assets/images/edtech.png";
    //
    // final imageDir = await getLocalImagePath(url);
    //
    // NotificationMessage message = NotificationMessage.fromPluginTemplate(
    //   body,
    //   title,
    //   body,
    //   image: imageDir,
    // );
    // winNotifyPlugin.showNotificationPluginTemplate(message);
  }

  void checkAndUpdateTime() {
    var now = DateTime.now();
    if (now.minute != currentMinute.value) {
      updateTime();
    }
  }

  void updateTime() {
    var now = DateTime.now();
    currentHour.value = now.hour;
    currentMinute.value = now.minute;
    // if (currentHour.value == 0 && currentMinute.value == 1) {
    //   getCurrentDay();
    // }
    int day = 6 - currentDay.value;
    // Iterate over all tasks
    for (var task in tasks) {
      if (task.dateTime.day <= day &&
          (task.dateTime.day + (task.daysDuration ?? 1)) > day) {
        // If the task starts now
        if (task.dateTime.hour == currentHour.value &&
            task.dateTime.minutes == currentMinute.value) {
          // Send notification for task start
          scheduleNotification(
            title: "تذكير بالمهمة",
            body:
                " حان وقت ${task.title} لمدة : ${(task.minutesDuration ~/ 60) != 0 ? '${(task.minutesDuration ~/ 60).toString().padLeft(1, '0')}h' : ''} ${(task.minutesDuration % 60 ~/ 1).toString().padLeft(2, '0')}m",
          );
        }

        DateTime taskEndTime = DateTime(now.year, now.month, now.day,
            task.dateTime.hour, task.dateTime.minutes + task.minutesDuration);

        // If the task is ending now
        if (taskEndTime.hour == currentHour.value &&
            taskEndTime.minute == currentMinute.value) {
          // Send notification for task end
          scheduleNotification(
            title: "انتهاء المهمة",
            body: "لقد انتهت المهمة ${task.title}",
          );
        }
      }
    }
  }

  void getCurrentDay() {
    final now = DateTime.now();
    currentDay.value = (now.weekday + 1) % 7;
  }
  void changeCurrentDay(int day) {

    currentDay.value =day;
 scrollToCurrentHour(100, 7);
  }
//------------
  ScrollController timeVerticalController = ScrollController();
  void scrollToCurrentHour(int cellHeight, int startHour) {

    Future.delayed(Duration.zero).then((_) {
      int hour = DateTime.now().hour;

      double scrollOffset = ((hour - startHour) * cellHeight.toDouble()) ;
      timeVerticalController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCirc,
      );
    });
  }
//------------
  void loadTasksFromStorage() {
    final storedTasks = box.read<List>('tasks') ?? [];

    tasks.value = storedTasks.map((task) {
      return TimePlannerTask(
        color: Color(task['color']),
        icon: colorController
            .iconChoices[colorController.iconChoices
                .indexWhere((iconModel) => iconModel.color == task['color'])]
            .icon,
        title: task['title'],
        dateTime: TimePlannerDateTime(
          day: task['dateTime']['day'],
          hour: task['dateTime']['hour'],
          minutes: task['dateTime']['minutes'],
        ),
        minutesDuration: task['minutesDuration'],
        daysDuration: task['daysDuration'],
        onTap: () {
          showTaskDetailsDialog(
            title: task['title'],
            dayIndex: task['dateTime']['day'],
            hour: task['dateTime']['hour'],
            minutes: task['dateTime']['minutes'],
            duration: task['minutesDuration'],
            daysDuration: task['daysDuration'],
            icon: colorController.iconChoices[task['iconIndex'] ?? 0].icon,
            color: task['color'],
            iconIndex: task['iconIndex'] ?? 0,
          );
        },
      );
    }).toList();
  }

  void resetFormFields() {
    taskNameController.value.text = '';
    // taskDescriptionController.value.text = '';
    selectedStartTime.value = TimeOfDay.now();
    duration.value = 15;
    colorController.selectedColor.value = colorController.iconChoices[0].color;
    colorController.selectedIcon.value = colorController.iconChoices[0].icon;
  }
  //-----------------------------> Task Management Functions <-----------------------------------\\

  void addTask({
    required String title,
    required int hour,
    required int minutes,
    required int duration,
    required IconData icon,
    required int color,
    required context,
  }) {
    final connectedDays = findConnectedDays();
    if (title.isEmpty) {
      KLoaders.errorSnackBar(
        message: 'العنوان لا يمكن أن يكون فارغًا',
        title: 'خطأ',
      );
      return;
    }

    if (!selectedDays.contains(true)) {
      KLoaders.errorSnackBar(
          message: 'يجب اختيار يوم واحد على الأقل', title: 'خطأ');
      return;
    }

    for (var group in connectedDays) {
      final dayIndex = group.first;
      final daysDuration = group.length;
      int iconIndex = colorController.iconChoices
          .indexWhere((iconModel) => iconModel.icon == icon);
      final task = TimePlannerTask(
        color: Color(color),
        icon: icon,
        iconIndex: iconIndex,
        title: title,
        dateTime: TimePlannerDateTime(
          day: dayIndex,
          hour: hour,
          minutes: minutes,
        ),
        minutesDuration: duration,
        daysDuration: daysDuration,
        onTap: () {
          showTaskDetailsDialog(
            title: title,
            dayIndex: dayIndex,
            hour: hour,
            minutes: minutes,
            duration: duration,
            daysDuration: daysDuration,
            icon: icon,
            color: color,
            iconIndex: iconIndex,
          );
        },
      );
      tasks.add(task);
    }

    taskNameController.value.clear();
    saveTasksToStorage();
    KLoaders.successSnackBar(
      message: 'تمت إضافة المهمة بنجاح',
      title: 'تمت العملية',
    );
  }

  // ignore: non_constant_identifier_names
  void UpdateTask({
    required int? index,
    required String title,
    required int hour,
    required int minutes,
    required int duration,
    required IconData icon,
    required int color,
    required context,
  }) {
    if (index != null) {
      // Remove the old version of the task
      tasks.removeAt(index);

      // Find connected days based on the toggled days
      final connectedDays = findConnectedDays();
      if (title.isEmpty) {
        KLoaders.errorSnackBar(
            message: 'العنوان لا يمكن أن يكون فارغًا', title: 'خطأ');
        return;
      }

      if (!selectedDays.contains(true)) {
        KLoaders.errorSnackBar(
            message: 'يجب اختيار يوم واحد على الأقل', title: 'خطأ');
        return;
      }

      // Add the tasks in the list at the correct position using insert
      for (var group in connectedDays) {
        final dayIndex = group.first;
        final daysDuration = group.length;
        int iconIndex = colorController.iconChoices
            .indexWhere((iconModel) => iconModel.color == color);
        final task = TimePlannerTask(
          color: Color(color),
          icon: icon,
          iconIndex: iconIndex,
          title: title,
          dateTime: TimePlannerDateTime(
            day: dayIndex,
            hour: hour,
            minutes: minutes,
          ),
          minutesDuration: duration,
          daysDuration: daysDuration,
          onTap: () {
            showTaskDetailsDialog(
              title: title,
              dayIndex: dayIndex,
              hour: hour,
              minutes: minutes,
              duration: duration,
              daysDuration: daysDuration,
              icon: icon,
              color: color,
              iconIndex: iconIndex,
            );
          },
        );
        // Insert the task at the correct position
        tasks.insert(index!, task);
        index++;
      }

      saveTasksToStorage();

      taskNameController.value.clear();
      showUpdateTask.value = false;
      colorController.selectedIcon.value = Icons.work;
      colorController.selectedName.value = "عمل";
      colorController.selectedColor.value = 0xFF2196F3;

      KLoaders.successSnackBar(
        message: 'تم تحديث المهمة بنجاح',
        title: 'تمت العملية',
      );
    }
  }

  void removeTask({
    required String title,
    required int dayIndex,
    required int hour,
    required int minutes,
    required int duration,
    required int daysDuration,
    required IconData icon,
    required int color,
  }) {
    final index = findTaskIndex(
      title: title,
      dayIndex: dayIndex,
      hour: hour,
      minutes: minutes,
      duration: duration,
      daysDuration: daysDuration,
      icon: icon,
      color: color,
    );
    if (index != null) {
      tasks.removeAt(index);
      Get.back();
      saveTasksToStorage();

      showUpdateTask.value = false;
      KLoaders.successSnackBar(
        message: 'تمت إزالة المهمة بنجاح',
        title: 'تمت العملية',
      );
    }
  }

  void updateTaskDetails(
    Map<String, dynamic> task,
  ) {
    final index = findTaskIndex(
      title: task['title'],
      dayIndex: task['dateTime']['day'],
      hour: task['dateTime']['hour'],
      minutes: task['dateTime']['minutes'],
      duration: task['minutesDuration'],
      daysDuration: task['daysDuration'],
      icon: colorController.iconChoices[task['iconIndex'] ?? 0].icon,
      color: task['color'],
    );

    if (index != null) {
      taskNameController.value.text = task['title'];
      selectedStartTime.value = TimeOfDay(
          hour: task['dateTime']['hour'], minute: task['dateTime']['minutes']);

      // Calculate end time based on start time and duration
      duration.value = task['minutesDuration'].toDouble();
      colorController.selectedColor.value = task['color'];
      colorController.selectedIcon.value =
          colorController.iconChoices[task['iconIndex'] ?? 0].icon;
      // Update selectedDays based on daysDuration and dayIndex
      for (int i = 0; i < daysOfWeek.length; i++) {
        if ((6 - i) >= task['dateTime']['day'] &&
            (6 - i) < task['dateTime']['day'] + task['daysDuration']) {
          selectedDays[i] = true;
        } else {
          selectedDays[i] = false;
        }
      }
      taskUpdateIndex.value = index;
      showUpdateTask.value = true;
      showAddTask.value = true;
      Get.back();
    } else {
      KLoaders.warningSnackBar(
          title: 'خطأ',
          message: 'لم يتم العثور على المهمة',
         );
    }
  }

  int? findTaskIndex({
    required String title,
    required int dayIndex,
    required int hour,
    required int minutes,
    required int duration,
    required int daysDuration,
    required IconData icon,
    required int color,
  }) {
    for (int i = tasks.length - 1; i >= 0; i--) {
      final task = tasks[i];
      final matches = task.title == title &&
          task.dateTime.day == dayIndex &&
          task.dateTime.hour == hour &&
          task.dateTime.minutes == minutes &&
          task.minutesDuration == duration &&
          task.daysDuration == daysDuration &&
          // task.icon == icon &&
          task.color!.value == color;
      if (matches) {
        return i;
      }
    }
    return null;
  }

  void saveTasksToStorage() {
    final taskList = tasks.map((task) => task.toJson()).toList();
    box.write('tasks', taskList);
  }

  void clearAllTasks() {
    tasks.clear();
    box.write('tasks', []);
  }

  //-----------------------------> UI Interaction Functions <-----------------------------------\\

  void showTaskDetailsDialog({
    required String title,
    required int dayIndex,
    required int hour,
    required int minutes,
    required int duration,
    required int daysDuration,
    required IconData icon,
    required int color,
    required int iconIndex,
  }) {
    Get.defaultDialog(
      title: 'تفاصيل المهمة',
      content: Text(
        ' الاسم : $title\n  لمدة : ${(duration ~/ 60) != 0 ? '${(duration ~/ 60).toString().padLeft(1, '0')}h' : ''} ${(duration % 60 ~/ 1).toString().padLeft(2, '0')}m',
        style: Theme.of(Get.context!).textTheme.bodyMedium,
        textAlign: TextAlign.right,
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('إغلاق'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          removeTask(
            title: title,
            dayIndex: dayIndex,
            hour: hour,
            minutes: minutes,
            duration: duration,
            daysDuration: daysDuration,
            icon: icon,
            color: color,
          );
        },
        child: const Text('حذف'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            updateTaskDetails(
              {
                'title': title,
                'dateTime': {
                  'day': dayIndex,
                  'hour': hour,
                  'minutes': minutes,
                },
                'minutesDuration': duration,
                'daysDuration': daysDuration,
                'color': color,
                'iconIndex': iconIndex,
              },
            );
          },
          child: const Text('تحديث'),
        ),
      ],
    );
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime.value,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    selectedStartTime.value = picked ?? selectedStartTime.value;
  }

  void toggleDay(int index) {
    selectedDays[index] = !selectedDays[index];
  }

  void updateCellWidth(double newWidth) {
    cellWidth.value = newWidth.toInt();
  }

//-----------------------------> Utility Functions <-----------------------------------\\

  List<List<int>> findConnectedDays() {
    List<List<int>> connectedDays = [];
    List<int> currentGroup = [];
    // Convert selectedDays from right-to-left to left-to-right
    List<bool> convertedSelectedDays = List.from(selectedDays.reversed);
    for (int i = 0; i < convertedSelectedDays.length; i++) {
      if (convertedSelectedDays[i]) {
        currentGroup.add(i);
      } else if (currentGroup.isNotEmpty) {
        connectedDays.add(List.from(currentGroup));
        currentGroup.clear();
      }
    }
    if (currentGroup.isNotEmpty) {
      connectedDays.add(currentGroup);
    }

    return connectedDays;
  }
}
