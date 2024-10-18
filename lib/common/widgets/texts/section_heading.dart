import 'package:flutter/material.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KSectionHeading extends StatelessWidget {
  const KSectionHeading({
    super.key,
    this.showAchtionButton = true,
    this.textColor,
    required this.title,
    this.buttonText = "عرض الكل",
    this.onPressed,
  });
  final bool showAchtionButton;
  final Color? textColor;
  final String title, buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final darkMode = KHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: textColor ?? (darkMode ? KColors.light : KColors.dark),
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showAchtionButton)
          TextButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonText,
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                        color: textColor ?? (darkMode ? KColors.light : KColors.dark),
                      ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: textColor ?? (darkMode ? KColors.light : KColors.dark),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
