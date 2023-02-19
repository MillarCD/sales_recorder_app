import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:register_sale_app/providers/login_provider.dart';
import 'package:register_sale_app/providers/order_provider.dart';

import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/screens/screens.dart';
import 'package:register_sale_app/themes/themes.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
      ChangeNotifierProvider<ProductProvider>(create: (context) => ProductProvider(), lazy: false,),
      ChangeNotifierProvider<SaleProvider>(create:(context) => SaleProvider()),
      ChangeNotifierProvider<OrderProvider>(create: (context) => OrderProvider()),
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sales Recorder',
      theme: LightTheme.theme,
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
        'sale': (context) => const SaleScreen(),
        'products': (context) => const ProductsScreen(),
        'select_product': (context) => const SelectProductScreen(),
        'barcode_reader': (context) => const BarcodeReaderScreen(),
        'order': (context) => const OrderScreen(),
        'create_product': (context) => const CreateProductScreen(),
        'scan_code': (context) => const ScanCodeScreen(),
      },

    );
  }
}
