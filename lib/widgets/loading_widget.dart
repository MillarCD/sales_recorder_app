import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {

  bool showMessage = false;

  Future<void> timeToShowMsg() async {
    await Future.delayed( const Duration(seconds: 5) );
    showMessage = true;
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    timeToShowMsg();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),

          const SizedBox(height: 30,),

          if (showMessage) const Text(
            'Revisa tu conexión a internet',
            style: TextStyle(fontSize: 19),
          )
        ],
      ),
    );
  }
}
