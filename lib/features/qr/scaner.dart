import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerController extends GetxController {
  var scannedData = <String>{}.obs;
  var isScanning = false.obs;

  void addScannedData(String data) {
    scannedData.add(data);
    print('Scanned Data: $data');
    if (scannedData.length >= 10) {
      Get.back();
      Get.snackbar('Sync', 'We are synced');
    }
  }

  void startScanning() {
    isScanning.value =   !isScanning.value;
  }

  void stopScanning() {
    isScanning.value = false;
  }
}

class QRScannerScreen extends StatelessWidget {
  final QRScannerController controller = Get.put(QRScannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Obx(() {
              if (controller.isScanning.value) {
                return MobileScanner(
                  onDetect: (BarcodeCapture barcodeCapture) {
                    for (final barcode in barcodeCapture.barcodes) {
                      if (barcode.rawValue != null) {
                        final String code = barcode.rawValue!;
                        controller.addScannedData(code);
                      }
                    }
                  },
                );
              } else {
                return Center(child: Text('Press the button to start scanning'));
              }
            }),
          ),
          ElevatedButton(
            onPressed: controller.startScanning,
            child: Text('Start Scanning'),
          ),
        ],
      ),
    );
  }
}