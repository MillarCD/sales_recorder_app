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

    productfilteredList = productFilterByRegister(filteredList);

    setState(() {});
  }

  List<Product> productFilterByRegister(List<Product> productList) {
    return [
      ...productList.where((product) {
        final int code = product.code;
        return product.quantity!=0 && [...registeredProducts.where((p) => p.code == code)].isEmpty;
    })];
  }

  @override
  void initState() {
    initProductList = Provider.of<ProductProvider>(context, listen: false).products;
    registeredProducts = Provider.of<SaleProvider>(context, listen: false).getProducts();
    

    
    productfilteredList = initProductList;

    productfilteredList = productFilterByRegister(productfilteredList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Selecciona un producto'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _SearchBar(onChanged: (value) => productsFilter(value),),

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: productfilteredList.length,
                  itemBuilder: (context, index) {
                    final Product product = productfilteredList[index];
              
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, product);
                      },
                      child: ProductCard(product: product),
                    );
                  },
                ),
              ),
          
            ],
          ),
        ),
      )
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Buscar Producto',
        hintStyle: TextStyle(color:secondaryColor),
        prefixIcon: Icon(Icons.search, color: secondaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
      onChanged: onChanged,
    );
  }
}