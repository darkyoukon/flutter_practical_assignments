import 'package:flutter/material.dart';
import 'screens/home/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'sans-serif',
          textTheme:
          const TextTheme(bodyText2: TextStyle(color: Color(0xffe9eef4)))),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}