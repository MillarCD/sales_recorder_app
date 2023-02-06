import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/widgets/product_card.dart';

class ProductsList extends StatefulWidget {

  const ProductsList({Key? key, this.filter, this.returnProduct = false}) : super(key: key);

  final List<Product> Function(List<Product> lista)? filter;
  final bool returnProduct;

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  List<Product> initProductList = [];
  List<Product> productfilteredList = [];

  void productsFilter(String value) {
    setState(() {
      List<Product> filteredList = Provider.of<ProductProvider>(context, listen: false).filterByPatterns(value);
      if (widget.filter == null) {
        productfilteredList = filteredList;
        return;
      }
      productfilteredList = widget.filter!(filteredList);
    });
  }


  @override
  void initState() {
    super.initState();
    initProductList = Provider.of<ProductProvider>(context, listen: false).products;
    
    productfilteredList = initProductList;
    if (widget.filter == null) return;
    productfilteredList = widget.filter!(productfilteredList);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
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
                  onTap: () => (widget.returnProduct) ? Navigator.pop(context, product) : null,
                  child: ProductCard(product: product),
                );
              },
            ),
          ),
        
        ],
      ),
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