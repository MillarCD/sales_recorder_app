import 'package:flutter/material.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';

class CreateProductScreen extends StatelessWidget {

  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo producto'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              TextFormField(

              ),

              AddProductButton(
                title: 'Crear producto',
                onPressed: () {
                  // TODO: crear producto con el producto provider
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}