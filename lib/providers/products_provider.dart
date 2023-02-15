import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';

class ProductProvider extends ChangeNotifier {

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoadingProducts = false;
  bool get isLoadingProduct => _isLoadingProducts;

  bool _isRegistering = false;
  bool get isRegistering => _isRegistering;

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

  bool checkProductByCode(int code) {
    for (Product product in _products) {
      if (product.code == code) return true;
    }
    return false;
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
      final String s = "${product.name} ${product.brand ?? ''}";
      return [...regExp.allMatches(s)].isNotEmpty;
    })];
  }

  Future<bool> registerProduct(Product newProduct) async {
    const String sheetName = 'productos';
    const String quantityFormule = '''=SUMA(
        SUMA(
          SI.ERROR(
            filter(egresos!H2:H,egresos!C2:C=INDIRECT("A"&ROW())),
            0
          )
        )
        -
        SUMA(
          SI.ERROR(
            filter(ingresos!F2:F,ingresos!B2:B=INDIRECT("A"&ROW())),
            0
          )
        )
      )
    ''';

    _isRegistering = true;
    notifyListeners();

    // CODE NAME BRAND PRICE QUANTITY
    bool res = await SpreadsheetService.ssService.appendRows(
      sheetName,
      [[
        ...newProduct.toList(),
        quantityFormule
      ]]
    );

    if (!res) {
      _isRegistering = false;
      notifyListeners();
      return false;
    }

    _products.add(newProduct);
    _isRegistering = false;
    notifyListeners();
    return true;
  }

}