import 'package:flutter/material.dart';
import 'package:edtech/time_planer/src/config/global_config.dart' as config;

/// Title widget for time planner
class TimePlannerTitle extends StatelessWidget {
  /// Title of each day, typically is name of the day for example sunday
  ///
  /// but you can set any things here
  final String title;

  /// Text style for title
  final TextStyle? titleStyle;

  /// Text style for date text
  final TextStyle? dateStyle;

  /// Title widget for time planner
  const TimePlannerTitle({
    Key? key,
    required this.title,
    this.titleStyle,
    this.dateStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: config.cellWidth!.toDouble(),
      child: Center(
        child: FittedBox(
          child: Text(
            title,
            style: titleStyle ?? const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}


