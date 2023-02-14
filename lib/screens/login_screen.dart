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
      color: Theme.of(context).colorScheme.background
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

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    Text(
                      'Iniciar seción',
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        fontWeight: FontWeight.w500
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
                      ),
                      validator: (value) {
                        if (value == null || value == '') return 'Ingrese una contraseña';
                        if (!loginProvider.checkPassword(value)) return 'Contraseña incorrecta';
                        return null;
                      }
                    )
                
                  ],
                ),
              ),
            )
          ),

          const SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'Iniciar seción',
                style: TextStyle(fontSize: 21, color: Theme.of(context).colorScheme.onSecondary),
              ),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                }
              }
            ),
          )
        ],
      ),
    );
  }
}