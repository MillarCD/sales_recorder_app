
class Product {
  final String name;
  final String? brand;
  final int price;
  final int code;
  int quantity;
  
  Product({
    required this.name,
    this.brand,
    required this.price,
    required this.code,
    required this.quantity,
  });

  factory Product.fromList(List<String> productList) {
    return Product(
      code: int.parse(productList[0]),
      name: productList[1],
      brand: (productList[2]=='') ? null : productList[2],
      price: int.parse(productList[3]),
      quantity: int.parse(productList[4])
    );
  }

  List<dynamic> toList() {
    return [code, name, brand, price];
  }
}