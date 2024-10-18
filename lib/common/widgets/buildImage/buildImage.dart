
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edtech/common/widgets/buildImage/image_selection_screen.dart';

Widget buildImage(context, String ref, TextEditingController textController) {
  return ElevatedButton(
      onPressed: () {
        Get.to(
          ImageSelectionScreen(
            ref: ref,
            textController: textController,
          ),
        );
      },
      child: const Text(' اختر صوره '));
}
