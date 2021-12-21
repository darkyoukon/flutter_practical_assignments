import 'package:flutter/material.dart';
import 'package:second_pa_telegram/screens/home/named_route_sample.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        NamedRouteSample.routeName: (context) => const NamedRouteSample(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == NamedRouteSample.altRouteName) {
          return MaterialPageRoute(
            builder: (context) {
              return NamedRouteSample(msg: settings.arguments as String);
            },
          );
        }
      },
      //home: const Home(),
    );
  }
}