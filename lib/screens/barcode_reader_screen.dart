import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';

class BarcodeReaderScreen extends StatelessWidget {

  const BarcodeReaderScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final MobileScannerController  controller = MobileScannerController(
      /*
      formats: [
        BarcodeFormat.itf,
      ]
      */
      facing: CameraFacing.front,
    );

    return Scaffold(
      body: MobileScanner(
        allowDuplicates: false,
        controller: controller,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            print('[BARCODE READER]: Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            print('[BARCODE READER] type: ${barcode.type}');
            print('[BARCODE READER]: Barcode found! $code');

            Product? product = Provider.of<ProductProvider>(context, listen: false).findProductByCode(int.parse(code));
            
            if (product == null) return;

            Navigator.pop(context, product);
          }
        },
      ),

      floatingActionButton: Row(
        children: [
          TextButton(
            child: const Text('Cancelar'),
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