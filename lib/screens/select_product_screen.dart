import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/widgets/product_card.dart';

class SelectProductScreen extends StatefulWidget {

  const SelectProductScreen({Key? key}) : super(key: key);

  @override
  State<SelectProductScreen> createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {

  List<Product> initProductList = [];
  List<Product> registeredProducts = [];
  List<Product> productfilteredList = [];

  void productsFilter(String value) {
    List<Product> filteredList = Provider.of<ProductProvider>(context, listen: false).filterByPatterns(value);

    productfilteredList = [
      ...filteredList.where((product) {
        final int code = product.code;
        return [...registeredProducts.where((p) => p.code == code)].isEmpty;
      })
    ];

    setState(() {});
  }

  @override
  void initState() {
    initProductList = Provider.of<ProductProvider>(context, listen: false).products;
    registeredProducts = Provider.of<SaleProvider>(context, listen: false).getProducts();
    
    productfilteredList = initProductList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('Selecciona un producto', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefix: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
                ),
                onChanged: (value) => productsFilter(value),
              ),
            ),
      
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: productfilteredList.length,
                itemBuilder: (context, index) {
                  final Product product = productfilteredList[index];
            
                  return GestureDetector(
                    onTap: () {
                      print('[GESTURE DETECTOR] product: ${product.name}');
                      Provider.of<SaleProvider>(context, listen: false).addNewProduct(product);
                      Navigator.pop(context);
                    },
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
        
          ],
        ),
      )
    );
  }
}