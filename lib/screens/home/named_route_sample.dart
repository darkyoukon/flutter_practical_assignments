import 'package:flutter/material.dart';

class NamedRouteSample extends StatelessWidget {
  final String message;

  const NamedRouteSample({Key? key, String? msg}) :
        message = msg ?? "", super(key: key);
  static const routeName = '/second';
  static const altRouteName = '/third';

  @override
  Widget build(BuildContext context) {
    final String arg = message == "" ? ModalRoute.of(context)!.settings.arguments as String : message;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text(arg),
        ),
      ),
    );
  }
}