import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';

class CreateProductScreen extends StatelessWidget {

  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    final TextEditingController codeController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController brandController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    if (productProvider.isRegistering) {
      return Scaffold(
      body: Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary)),
    );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo producto'),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              children: [

                TextFormField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Codigo'),
                  validator: (value) {
                    final int? code;
                    if ((code = int.tryParse(value ?? '')) == null) return 'Debe ingresar un número valido.';

                    if (productProvider.checkProductByCode(code!)) {
                      return 'El codigo ya esta registrado';
                    }
                    return null;
                  },
                ),
        
                const SizedBox(height: 10,),

                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Nombre del Producto'),
                  validator: (value) {
                    if (value == null || value == '') return 'Debe ingresar un nombre';
                    return null;
                  },
                ),
        
                const SizedBox(height: 10,),
        
                TextFormField(
                  controller: brandController,
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Marca'),
                ),
        
                const SizedBox(height: 10,),
        
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Precio'),
                  validator: (value) {
                    final int? price;
                    if ((price = int.tryParse(value ?? '')) == null) return 'Debe ingresar un precio valido';
                    if (price !< 1) return 'Debe ingresar un valor positivo';

                    return null;
                  },
                ),


        
        
                AddProductButton(
                  title: 'Crear producto',
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;
                      
                      final bool res = await productProvider.registerProduct(
                        Product(
                          name: nameController.text,
                          code: int.parse(codeController.text),
                          brand: brandController.text,
                          price: int.parse(priceController.text),
                          quantity: 0,
                        )
                      );

                      if (res == true) {
                        codeController.text = '';
                        nameController.text = '';
                        brandController.text = '';
                        priceController.text = '';
                        return;
                      }

                      showSnackBar(
                        const SnackBar(
                          content: Text('Error... No se pudo agregar el producto'),                          
                        )
                      );
                    }

                  },
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textFormFieldDecoration(Color borderColor, String hintText) {
    return InputDecoration(
      labelText: hintText,
    );
  }
}