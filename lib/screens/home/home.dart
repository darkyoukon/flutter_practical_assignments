// screens/home/home.dart

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/painting.dart';
import 'package:second_pa_telegram/screens/home/tab_bar_screens/all.dart';
import 'package:second_pa_telegram/screens/home/tab_bar_screens/family.dart';

import 'package:tab_indicator_styler/tab_indicator_styler.dart';

final List<String> entries = <String>['Saved Messages', 'Мама', 'Папа',
                                      'Любимая', 'Брат', 'Сестра',
                                      'Алла Ивановна', 'Павел Дуров',
                                      'Mark Zuckerberg', 'Deleted contact',
                                      'Test', 'test2', 'test3', 'test test'];
final List<int> rndState = entries.map((x) => Random().nextInt(4)).toList();
final List<int> rndMsgs = rndState.map((x) => x == 3 ? Random().nextInt(8)+1 : 0).toList();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _StateHome();
}

class _StateHome extends State<Home> with SingleTickerProviderStateMixin {
  final _bottomNavBarItems = [
    const Tab(
      icon: Text('  All  '),
    ),
    const Tab(
      icon: Text('  Family  '),
    ),
    const Tab(
      icon: Text('  Empty  '),
    )
  ];
  int _count = 0;
  int _currentIndex = 0;
  bool isFabVisible = true;

  PageController _pageController = PageController(initialPage: 0);
  TabController? _tabController;
  var _scrollController = ScrollController();

  late Future futImages;
  Future<List<String>> initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    return manifestMap.keys
        .where((String key) => key.contains('images/'))
        .toList();
  }
  @override
  void initState() {
    _tabController = TabController(length: _bottomNavBarItems.length, vsync: this);
    _tabController!.addListener(() {

    });
    futImages = initImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Scaffold(
      backgroundColor: const Color(0xff1d2733),
      body: NestedScrollView(
        controller: _scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled)  => [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    sliver: SliverAppBar(
                      floating: true,
                      elevation: 0,
                      leading: const Icon(Icons.menu, size: 25),
                      backgroundColor: const Color(0xff212d3b),
                      title: const Text('Telegram',
                          style: TextStyle(fontSize: 20.5)),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('This is a snackbar')));
                          },
                        )
                      ],
                    )
                  )
                )
              ],
              body: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (newIndex) {
                  setState(() {
                    _tabController!.animateTo(newIndex, curve: Curves.bounceInOut);
                    _currentIndex = newIndex;
                  });
                },
                children: [
                  NotificationListener<UserScrollNotification>(
                      onNotification: (notificationInfo) {
                        if (notificationInfo.direction == ScrollDirection.forward) {
                          setState(() {
                            isFabVisible = true;
                          });
                        } else if (notificationInfo.direction == ScrollDirection.reverse) {
                          setState(() {
                            isFabVisible = false;
                          });
                        }
                        return true;
                      },
                      child: AllScreen()
                  ),
                  NotificationListener<UserScrollNotification>(
                      onNotification: (notificationInfo) {
                        if (notificationInfo.direction == ScrollDirection.forward) {
                          setState(() {
                            isFabVisible = true;
                          });
                        } else if (notificationInfo.direction == ScrollDirection.reverse) {
                          setState(() {
                            isFabVisible = false;
                          });
                        }
                        return true;
                      },
                      child: FamilyScreen()
                  ),
                  NotificationListener<UserScrollNotification>(
                      onNotification: (notificationInfo) {
                        if (notificationInfo.direction == ScrollDirection.forward) {
                          setState(() {
                            isFabVisible = true;
                          });
                        } else if (notificationInfo.direction == ScrollDirection.reverse) {
                          setState(() {
                            isFabVisible = false;
                          });
                        }
                        return true;
                      },
                      child: Container()
                  )
                ],
              )
          ),
      floatingActionButton: isFabVisible ? FloatingActionButton(
          tooltip: 'Increment Counter',
          backgroundColor: const Color(0xff5fa3de),
          onPressed: () {  },
          child: const Icon(Icons.create_rounded)
      ) : null,
      bottomNavigationBar: ColoredBox(
            color: const Color(0xff212d3b),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                  height: 5,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  horizontalPadding: 0,
                  tabPosition: TabPosition.top,
                  color: const Color(0xff64b5ef)
              ),
              tabs: _bottomNavBarItems,
              onTap: (newIndex) {
                setState(() {
                  _pageController.animateToPage(newIndex, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                });
              },
            )
        )
    )
  );
}