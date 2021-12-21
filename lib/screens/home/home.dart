// screens/home/home.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:second_pa_telegram/screens/home/tab_screens/page_view.dart';
import 'package:second_pa_telegram/screens/home/tab_screens/shared_prefs.dart';

import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'home_model.dart';
import 'named_route_sample.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _StateHome();
}

class _StateHome extends State<Home> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation rotationAnimation;

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
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    rotationAnimation = Tween(begin: 0.0, end: 6.28).animate(CurvedAnimation(curve: Curves.easeInOutBack, parent: controller));
    controller.repeat();

    Timer.periodic(
      const Duration(seconds: 15),
          (timer) {
            Future<http.Response> randomName = http.get(Uri.parse("https://www.name-generator.org.uk/quick/"));
            randomName.then((value) {
              Provider.of<HomeModel>(context, listen: false)
                  .changeAppName(parse(value.body)
                  .getElementsByClassName("name_heading")[0].text);
            });
          },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    Provider.of<HomeModel>(context, listen: false).disposeTabController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
          length: 3,
          child: Consumer<SharedPrefs>(builder: (context, prefs, _) {
            return Scaffold(
                backgroundColor: prefs.getTheme ? const Color(0xff1d2733) : const Color(0xffffffff),
                body: NestedScrollView(
                    controller: Provider.of<HomeModel>(context)
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
                                backgroundColor: prefs.getTheme ? const Color(0xff212d3b) : const Color(0xff4f7d9f),
                                title: Text(Provider.of<HomeModel>(context).appName,
                                    style: const TextStyle(fontSize: 20.5)),
                                actions: <Widget>[
                                  GestureDetector(
                                      onLongPress: () {
                                        Navigator.pushNamed(context, NamedRouteSample.altRouteName, arguments: "Complicated Widg");
                                      },
                                      child: AnimatedBuilder(
                                          animation: controller,
                                          builder: (context, child) => Transform.rotate(
                                              angle: rotationAnimation.value,
                                              child: IconButton(
                                                icon: Provider.of<SharedPrefs>(context).getTheme ?
                                                const Icon(Icons.brightness_medium) :
                                                const Icon(Icons.brightness_medium_outlined),
                                                onPressed: () {
                                                  Provider.of<SharedPrefs>(context, listen: false).changeTheme();
                                                },
                                              )
                                          )
                                      )
                                  )
                                ],
                              )))
                    ],
                    body: MyPageView(countIndex)),
                floatingActionButton:
                Provider.of<HomeModel>(context).isFabVisible
                    ? GestureDetector(
                    onLongPress: () {
                      Navigator.pushNamed(context, NamedRouteSample.routeName, arguments: "Sample Widg");
                    },
                    child: FloatingActionButton(
                        backgroundColor: const Color(0xff5fa3de),
                        onPressed: () {
                          setState(() {
                            countIndex++;
                          });
                        },
                        child: const Icon(Icons.create_rounded)
                    )
                ) : null,
                bottomNavigationBar: ColoredBox(
                    color: prefs.getTheme ? const Color(0xff212d3b) : const Color(0xff4f7d9f),
                    child: TabBar(
                      controller: Provider.of<HomeModel>(context)
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
                          color: prefs.getTheme ? const Color(0xff64b5ef) : const Color(0xfffefefd)),
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
                    )
                )
            );
          })
      );
}
