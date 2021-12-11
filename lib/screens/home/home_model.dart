import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  bool isFabVisible = true;

  void trueFabVisible() {
    isFabVisible = true;
    notifyListeners();
  }
  void falseFabVisible() {
    isFabVisible = false;
    notifyListeners();
  }


  PageController _pageController = PageController(initialPage: 0);
  PageController getPageController() {
    return _pageController;
  }

  var _scrollController = ScrollController();
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
}