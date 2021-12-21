import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_pa_telegram/screens/home/home_model.dart';
import 'package:second_pa_telegram/screens/home/tab_screens/shared_prefs.dart';
import 'app.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefs().init();
    return runApp(
        MultiProvider(
            providers: [
                ChangeNotifierProvider(
                    create: (context) => SharedPrefs(),
                ),
                ChangeNotifierProvider(
                    create: (context) => HomeModel(),
                )
            ],
            child: const App()
        )
    );
}