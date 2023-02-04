import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';

class OrderProvider extends ChangeNotifier {
  final Map<Product, List<double>> _products = {};
  Map<Product, List<double>> get products => _products;

  static const double tax = 0.19;

  bool _isRegistering = false;
  bool get isRegistering => _isRegistering;

  double? getTotal() {
    if (_products.isEmpty) return null;

    double total = 0;

    for (var entry in _products.entries) {
      total += entry.key.price * entry.value[0];
    }
    return total;
  }

  void addOneProduct(Product product) {
    if (_products[product] == null) return;
    
    _products[product]![0] = _products[product]![0] + 1;
    notifyListeners();
  }
  void removeOneProduct(Product product) {
    if (_products[product] == null || _products[product]![0] < 2) return;

    _products[product]![0] = _products[product]![0] - 1;
    notifyListeners();
  }

  void addNewProduct(Product product, double price) {
    if (isRegister(product.code)) return;
    
    _products.addAll({product: [1, price]});
    notifyListeners();
  }
  bool deleteProduct(Product product) {
    final List<double>? res = _products.remove(product);
    if(res == null) return false;
    
    notifyListeners();
    return true;
  }

  List<Product> getProducts() {
    return [..._products.entries.map((e) => e.key)];
  }

  bool isRegister(int code) {
    final List<MapEntry> res = [..._products.entries.where((entry) => entry.key.code == code)];
    if (res.isEmpty) return false;
    return true;
  }

  Future<bool> registerSale() async {
    const String sheetName = 'egresos';
    _isRegistering = true;
    notifyListeners();
    final List<String>? lastRow = await SpreadsheetService.ssService.getLastRow(sheetName, length: 1);

    if (lastRow == null) {
      _isRegistering = false;
      notifyListeners();
      return false;
    }

    final int numOrder = (lastRow.isEmpty) ? 1
      : ((int.tryParse(lastRow[0])==null) ? 1 : int.parse(lastRow[0]) + 1);
    
   
    final String dateTime = DateTime.now().toString();

    // N° VENTA |	CODIGO	| PRODUCTO	| MARCA	| PRECIO	| CANTIDAD	| TOTAL	| FECHA
    // N° COMPRA |	CODIGO	| PRODUCTO	| MARCA	| PROVEEDOR	| PRECIO (SIN IMPUESTO)	|
    // PRECIO (CON IMPUESTO)	| CANTIDAD	| TOTAL	| FECHA
    final List<List<dynamic>> order = [
      ...products.entries.map((entry) {
        final int code = entry.key.code;
        final String name = entry.key.name;
        final String? brand = entry.key.brand;
        final int price = entry.key.price; // necesitamos el precio del proovedoor
        // TODO: solucion: abrir un dialogo al seleccionar o escanear el producto

        return [
          numOrder,                     // N° venta
          ...entry.key.toList(),        // code, name, brand, price
          entry.value,                  // quantity
          entry.key.price * entry.value[0],// total
          dateTime                      // date
        ];
      }
    )];

    final bool res = await SpreadsheetService.ssService.appendRows(sheetName, order);

    if (!res) {
      _isRegistering = false;
      notifyListeners();
      return false;
    }

    for (var entry in _products.entries) {
      entry.key.quantity += entry.value[0].round();
    }

    _products.clear();
    _isRegistering = false;
    notifyListeners();
    return true;
  }

}