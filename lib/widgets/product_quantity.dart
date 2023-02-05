import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductQuantity extends StatelessWidget {

  final int quantity;
  final void Function() add;
  final void Function() rem;

  const ProductQuantity({
    Key? key,
    required this.quantity,
    required this.add,
    required this.rem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
        borderRadius: BorderRadius.circular(10)
      ),

      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                print('PRODUCT QUANTITY: se saco un producto');
                HapticFeedback.mediumImpact();
                rem();
              },
              icon: const Icon(Icons.remove),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(child: Text(quantity.toString(), style: const TextStyle(fontSize: 19))),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                print('PRODUCT QUANTITY: se sumo un producto');
                HapticFeedback.mediumImpact();
                add();
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}