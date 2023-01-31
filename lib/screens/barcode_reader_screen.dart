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
      facing: CameraFacing.back,
    );

    return Scaffold(
      body: MobileScanner(
        allowDuplicates: false,
        controller: controller,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) return;
          
          final String code = barcode.rawValue!;
          Product? product = Provider.of<ProductProvider>(context, listen: false).findProductByCode(int.tryParse(code) ?? -1);
    
          if (product == null) return;
          Navigator.pop(context, product);
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