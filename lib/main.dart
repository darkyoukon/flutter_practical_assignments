import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_pa_telegram/screens/home/home_model.dart';
import 'app.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: const App()
    )
);