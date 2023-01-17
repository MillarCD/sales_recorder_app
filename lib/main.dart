import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/screens/screens.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProductProvider>(create: (context) => ProductProvider()),
      ChangeNotifierProvider<SaleProvider>(create:(context) => SaleProvider()),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'products',
      routes: {
        'products': (context) => const ProductsScreen(),
        'sale': (context) => const SaleScreen(),
      },
    );
  }
}
