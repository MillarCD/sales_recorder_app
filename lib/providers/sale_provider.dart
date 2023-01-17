import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';

class SaleProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(name: 'Cuaderno Universitario', brand: 'FaberCastle', price: 2500, code: 1234),
    Product(name: 'Compas', price: 370, code: 987324)
  ];

  List<Product> get products => _products;

}