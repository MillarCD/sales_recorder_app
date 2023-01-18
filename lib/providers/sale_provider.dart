import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';

class SaleProvider extends ChangeNotifier {
  Map<Product, int> _products = {
    Product(name: 'Cuaderno Universitario', brand: 'FaberCastle', price: 2500, code: 1234): 3,
    Product(name: 'Compas', price: 370, code: 987324): 6,
    Product(name: 'Cartulina', price: 370, code: 987324): 6,
    Product(name: 'Regla', price: 679, code: 987324): 1,
    Product(name: 'Goma', price: 400, code: 987324): 2,
    Product(name: 'Goma Eva', price: 250, code: 987324): 10,
  };

  Map<Product, int> get products => _products;

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
    _products.addAll({product: 1});
    notifyListeners();
  }
}