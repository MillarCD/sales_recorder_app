import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends StatelessWidget {

  const ScanCodeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool barcodeRead = false;

    final MobileScannerController  controller = MobileScannerController(
      facing: CameraFacing.back,
    );

    return Scaffold(
      body: MobileScanner(
        allowDuplicates: false,
        controller: controller,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) return;

          final String code = barcode.rawValue!;

          if (!barcodeRead) {
            Navigator.pop(context, code);
            barcodeRead = true;
          }
          
        },
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: const Text('Cancelar', style: TextStyle(fontSize: 18)),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}