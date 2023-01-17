import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product>? _products;
  List<Product>? get products => _products;

  ProductProvider() {
    loadProducts();
  }
  

  Future<void> loadProducts() async {
    // TODO: cargar productos desde la api
    await Future.delayed(const Duration(seconds: 3));

    _products = [
      Product(name: 'Lapiz grafito', brand: 'Colon', price: 100, code: 123),
      Product(name: 'Cartulina', price: 200, code: 432),
      Product(name: 'Plumon', brand: 'Bic', price: 100, code: 1),
    ];

    notifyListeners();
  }

}