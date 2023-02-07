import 'package:flutter/material.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';

class CreateProductScreen extends StatelessWidget {

  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

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
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Codigo'),
                  validator: (value) {
                    // TODO: verificar que no este registrado
                    // TODO: verificar que sea un entero sin signo
                  },
                ),
        
                const SizedBox(height: 10,),

                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Nombre del Producto'),
                  validator: (value) {
                    // TODO: verificar que no este vacio
                  },
                ),
        
                const SizedBox(height: 10,),
        
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Marca'),
                  validator: (value) {
                    // TODO: Verificar que no este vacio
                  },
                ),
        
                const SizedBox(height: 10,),
        
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: textFormFieldDecoration(secondaryColor, 'Precio'),
                  validator: (value) {
                    // TODO: verificar que sea un numero entero positivo
                  },
                ),


        
        
                AddProductButton(
                  title: 'Crear producto',
                  onPressed: () {
                    // TODO: activar las verificaciones
                    // TODO: crear producto con el producto provider
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
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
        borderSide: BorderSide(color: borderColor)
      )


    );
  }
}