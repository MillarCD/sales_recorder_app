import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: const [

          _Background(),

          _LoginForm()
          
        ]
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blue,
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),

      child: Column(
        children: [

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Iniciar seción',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),

                  const SizedBox(height: 10,),
    
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: DropdownButton<String>(
                      enableFeedback: true,
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      items: [
                        ...loginProvider.getUsers().map((user) {
                          return DropdownMenuItem(
                            value: user,
                            child: Text(user),
                          );
                        })
                      ],

                      value: loginProvider.selectedUser,
                      onChanged: (onChanged) {
                        if (onChanged == null) return;

                        loginProvider.selectedUser = onChanged;
                      }
                    ),
                  ),

                  const SizedBox(height: 30,),
    
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value == '') return 'Ingrese una contraseña';
                      if (!loginProvider.checkPassword(value)) return 'Contraseña incorrecta';
                      return null;
                    }
                  )
    
                ],
              ),
            )
          ),

          const SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              child: const Text(
                'Iniciar seción',
                style: TextStyle(fontSize: 21),
              ),
              onPressed: () {
                print('Iniciar secion');
                if (formKey.currentState?.validate() ?? false) {
                  loginProvider.isSignIn = true;
                  // TODO: navegar a home screen
                  
                }
              }
            ),
          )
        ],
      ),
    );
  }
}