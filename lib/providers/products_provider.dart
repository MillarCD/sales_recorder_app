import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  ProductProvider() {
    loadProducts();
  }
  

  Future<void> loadProducts() async {
    List<List<String>>? productsList = await SpreadsheetService.ssService.getRows('productos');
    if (productsList == null) return;

    productsList = productsList.sublist(1,productsList.length);
    _products = [...productsList.map((list) => Product.fromList(list))];
   
    notifyListeners();
  }

  Product? findProductByCode(int code) {
    List<Product> product = [..._products.where((p) => p.code == code)];

    if (product.isEmpty) return null;

    return product[0];
  }

}