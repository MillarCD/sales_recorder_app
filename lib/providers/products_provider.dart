import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';

class ProductProvider extends ChangeNotifier {

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoadingProducts = false;
  bool get isLoadingProduct => _isLoadingProducts;

  ProductProvider() {
    loadProducts();
  }
  

  Future<void> loadProducts() async {
    _isLoadingProducts = true;
    notifyListeners();

    List<List<String>>? productsList = await SpreadsheetService.ssService.getRows('productos');
    if (productsList == null) {
      _isLoadingProducts = false;
      notifyListeners();
      return;
    }

    productsList = productsList.sublist(1,productsList.length);
    _products = [...productsList.map((list) => Product.fromList(list))];
   
    _isLoadingProducts = false;
    notifyListeners();
    return;
  }

  Product? findProductByCode(int code) {
    List<Product> product = [..._products.where((p) => p.code == code)];

    if (product.isEmpty) return null;

    return product[0];
  }

  List<Product> filterByPatterns(String pattern) {
    final String p = pattern.split(' ').reduce((acc, v) => '$acc|$v');
    RegExp regExp = RegExp(p, caseSensitive: false);

    return [..._products.where((product) {
      final String name = product.name;
      return [...regExp.allMatches(name)].isNotEmpty;
    })];
  }

  

}