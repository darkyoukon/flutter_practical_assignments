import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModel extends ChangeNotifier {
  void setDarkTheme() {
    SharedPreferences.getInstance()
        .then((prefs) {
          prefs.setBool("theme", !(prefs.getBool("theme") ?? true));
        });
    notifyListeners();
  }
  Future<bool> getDarkTheme() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getBool("theme") ?? true;
    });
  }

  bool isFabVisible = true;

  void trueFabVisible() {
    isFabVisible = true;
    notifyListeners();
  }
  void falseFabVisible() {
    isFabVisible = false;
    notifyListeners();
  }

  String appName = 'Telegram';
  void changeAppName(String newAppName) {
    appName = newAppName;
    notifyListeners();
  }

  final PageController _pageController = PageController(initialPage: 0);
  PageController getPageController() {
    return _pageController;
  }

  final _scrollController = ScrollController();
  ScrollController getScrollController() {
    return _scrollController;
  }

  late TabController _tabController;
  TabController getTabController() {
    return _tabController;
  }
  void setTabController(TabController innerTabController) {
    _tabController = innerTabController;
  }
  void disposeTabController() {
    _tabController.dispose();
  }


  void pageViewChange(int newIndex) {
    _tabController.animateTo(newIndex, curve: Curves.bounceInOut);
    notifyListeners();
  }

  Future<List<String>> initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    return manifestMap.keys
        .where((String key) => key.contains('images/'))
        .toList();
  }

  static final List<String> entries = <String>['Saved Messages', 'Мама', 'Папа',
    'Любимая', 'Брат', 'Сестра',
    'Алла Ивановна', 'Павел Дуров',
    'Mark Zuckerberg', 'Deleted contact',
    'Test', 'test2', 'test3', 'test test'];
  static final List rndState = entries.map((x) => Random().nextInt(4)).toList();
  static final List<int> rndMsgs = rndState.map((x) => x == 3 ? Random().nextInt(19)+1 : 0).toList();
}