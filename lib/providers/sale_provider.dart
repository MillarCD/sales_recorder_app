import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';

class SaleProvider extends ChangeNotifier {
  final Map<Product, int> _products = {};
  Map<Product, int> get products => _products;

  int? getTotal() {
    if (_products.isEmpty) return null;

    int total = 0;

    for (var entry in _products.entries) {
      total += entry.key.price * entry.value;
    }
    return total;
  }

  void addOneProduct(Product product) {
    if (_products[product] == null) return;
    
    _products[product] = _products[product] !+ 1;
    notifyListeners();
  }
  void removeOneProduct(Product product) {
    if (_products[product] == null || _products[product] !< 2) return;

    _products[product] = _products[product] !- 1;
    notifyListeners();
  }

  void addNewProduct(Product product) {
    if (isRegister(product.code)) return;
    
    _products.addAll({product: 1});
    notifyListeners();
  }
  bool deleteProduct(Product product) {
    final int? res = _products.remove(product);
    if(res == null) return false;
    
    notifyListeners();
    return true;
  }

  bool isRegister(int code) {
    final List<MapEntry> res = [..._products.entries.where((entry) => entry.key.code == code)];
    if (res.isEmpty) return false;
    return true;
  }

  Future<bool> registerSale() async {
    const String sheetName = 'ingresos';
    final List<String> lastRow = await SpreadsheetService.ssService.getLastRow(sheetName, length: 1);
    final int numVenta = (lastRow.isEmpty) ? 1
      : ((int.tryParse(lastRow[0])==null) ? 1 : int.parse(lastRow[0]) + 1);
    
   
    final String dateTime = DateTime.now().toString();

    // N° VENTA	CODIGO	PRODUCTO	MARCA	PRECIO	CANTIDAD	TOTAL	FECHA
    final List<List<dynamic>> sale = [
      ...products.entries.map((entry) {
        return [
          numVenta,                     // N° venta
          ...entry.key.toList(),        // code, name, brand, price
          entry.value,                  // quantity
          entry.key.price * entry.value,// total
          dateTime                      // date
        ];
      }
    )];

    final bool res = await SpreadsheetService.ssService.appendRows(sheetName, sale);

    if (!res) return false;

    _products.clear();
    notifyListeners();
    return true;
  }

}