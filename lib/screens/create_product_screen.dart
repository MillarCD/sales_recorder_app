import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';
import 'package:register_sale_app/widgets/loading_widget.dart';
import 'package:register_sale_app/widgets/snack_bar_content.dart';

class CreateProductScreen extends StatelessWidget {

  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    final TextEditingController codeController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController brandController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    if (productProvider.isRegistering) {
      return const Scaffold(
      body: LoadingWidget()
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
                  decoration: InputDecoration(
                    hintText: 'Codigo',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final String? code = await Navigator.pushNamed(context, 'scan_code') as String?;
                        if (code==null) return;

                        codeController.text = code;
                      },
                      icon: const Icon(Icons.camera_alt_outlined)
                    )
                  ),
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
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Producto',
                  ),
                  validator: (value) {
                    if (value == null || value == '') return 'Debe ingresar un nombre';
                    return null;
                  },
                ),
        
                const SizedBox(height: 10,),
        
                TextFormField(
                  controller: brandController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Marca',
                  ),
                ),
        
                const SizedBox(height: 10,),
        
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Precio'
                  ),
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

                        showSnackBar(
                        const SnackBar(
                          content: SnackBarContent(
                            icon: Icons.check_circle_outline,
                            iconColor: Colors.green,
                            message: 'Producto registrado'
                          )
                        )
                      );
                        return;
                      }

                      showSnackBar(
                        const SnackBar(
                          content: SnackBarContent(
                            icon: Icons.cancel_outlined,
                            iconColor: Colors.red,
                            message: 'Error... No se pudo agregar el producto'
                          )
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

}

