
class Product {
  final String name;
  final String? brand;
  final int price;
  final int code;
  
  Product({
    required this.name,
    this.brand,
    required this.price,
    required this.code,
  });
}