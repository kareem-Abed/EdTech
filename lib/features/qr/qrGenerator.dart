import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorController extends GetxController {
  var qrValue = 1000.obs;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(
        Duration(
            // seconds: 1
            milliseconds: 700,
        ), (timer) {
          print('Timer: ${qrValue.value}');
      qrValue.value++;
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class QRGeneratorScreen extends StatelessWidget {
  final QRGeneratorController controller = Get.put(QRGeneratorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('QR Generator', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => QrImageView(
                  data: controller.qrValue.value.toString(),
                  // version: QrVersions.auto,
                  size: 300.0,
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.startTimer,
              child: Text('Start'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.stopTimer,
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
