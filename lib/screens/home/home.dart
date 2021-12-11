// screens/home/home.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:second_pa_telegram/screens/home/page_view.dart';

import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'home_model.dart';

final List<String> entries = <String>[
  'Saved Messages',
  'Мама',
  'Папа',
  'Любимая',
  'Брат',
  'Сестра',
  'Алла Ивановна',
  'Павел Дуров',
  'Mark Zuckerberg',
  'Deleted contact',
  'Test',
  'test2',
  'test3',
  'test test'
];
final List<int> rndState = entries.map((x) => Random().nextInt(4)).toList();
final List<int> rndMsgs =
    rndState.map((x) => x == 3 ? Random().nextInt(8) + 1 : 0).toList();

class Home extends StatefulWidget {

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _StateHome();
}

class _StateHome extends State<Home> with SingleTickerProviderStateMixin {
  int countIndex = 0;

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

  @override
  void initState() {
    super.initState();
    Provider.of<HomeModel>(context, listen: false).setTabController(
        TabController(length: _bottomNavBarItems.length, vsync: this));
  }

  @override
  void dispose() {
    Provider.of<HomeModel>(context, listen: false).disposeTabController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color(0xff1d2733),
          body: NestedScrollView(
            controller: Provider.of<HomeModel>(context, listen: false)
                .getScrollController(),
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
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
                                    const SnackBar(
                                        content: Text('This is a snackbar')));
                              },
                            )
                          ],
                        )))
                  ],
              body: MyPageView(countIndex)),
          floatingActionButton:
              Provider.of<HomeModel>(context, listen: true).isFabVisible
                  ? FloatingActionButton(
                      tooltip: 'Increment Counter',
                      backgroundColor: const Color(0xff5fa3de),
                      onPressed: () {
                        setState(() => countIndex++);
                      },
                      child: const Icon(Icons.create_rounded))
                  : null,
          bottomNavigationBar: ColoredBox(
              color: const Color(0xff212d3b),
              child: TabBar(
                controller: Provider.of<HomeModel>(context, listen: false)
                    .getTabController(),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialIndicator(
                    height: 5,
                    bottomLeftRadius: 8,
                    bottomRightRadius: 8,
                    horizontalPadding: 0,
                    tabPosition: TabPosition.top,
                    color: const Color(0xff64b5ef)),
                tabs: _bottomNavBarItems,
                onTap: (newIndex) {
                  setState(() {
                    Provider.of<HomeModel>(context, listen: false)
                        .getScrollController().animateTo(Provider.of<HomeModel>(context, listen: false)
                        .getScrollController().position.minScrollExtent,
                        duration: const Duration(milliseconds: 300), curve: Curves.elasticOut);
                    Provider.of<HomeModel>(context, listen: false)
                        .getPageController()
                        .animateToPage(newIndex,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                  });
                },
              ))));
}
