import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({
    super.key,
    required this.title,
    required this.hintText, 
    required this.keyboardType,
    this.validate
  });

  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    
    return SimpleDialog(
      title: Text(title),
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,

            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color:Theme.of(context).colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              validator: validate,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancelar', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
            ),

            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  return Navigator.pop(context, controller.text);
                }
              },
              child: Text('Aceptar', style: TextStyle(color: Theme.of(context).colorScheme.secondary))
            ),

            const SizedBox(width: 5,)
          ],
        ),
      ],
    );
  }
}