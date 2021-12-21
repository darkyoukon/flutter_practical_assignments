import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends ChangeNotifier {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  bool get getTheme => _sharedPrefs.getBool('theme') ?? true;
  void changeTheme() {
    _sharedPrefs.setBool('theme', !getTheme);
    notifyListeners();
  }
}