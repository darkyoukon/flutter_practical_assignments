
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:second_pa_telegram/screens/home/tab_screens/all.dart';
import 'package:second_pa_telegram/screens/home/tab_screens/family.dart';

import 'home_model.dart';

class MyPageView extends StatelessWidget {
  final int countIndex;

  const MyPageView(this.countIndex, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, home, child) {
        return PageView(
          controller: home.getPageController(),
          scrollDirection: Axis.horizontal,
          onPageChanged: (newIndex) {
            /*setState(() {
              _tabController!.animateTo(newIndex, curve: Curves.bounceInOut);
              _currentIndex = newIndex;
            });*/
            home.pageViewChange(newIndex);
          },
          children: [
            NotificationListener<UserScrollNotification>(
                onNotification: (notificationInfo) {
                  if (notificationInfo.direction == ScrollDirection.forward) {
                    /*setState(() {
                      isFabVisible = true;
                    });*/
                    home.trueFabVisible();
                  } else if (notificationInfo.direction == ScrollDirection.reverse) {
                    /*setState(() {
                      isFabVisible = false;
                    });*/
                    home.falseFabVisible();
                  }
                  return true;
                },
                child: AllScreen(countIndex)
            ),
            NotificationListener<UserScrollNotification>(
                onNotification: (notificationInfo) {
                  if (notificationInfo.direction == ScrollDirection.forward) {
                    home.trueFabVisible();
                  } else if (notificationInfo.direction == ScrollDirection.reverse) {
                    home.falseFabVisible();
                  }
                  return true;
                },
                child: FamilyScreen(countIndex)
            ),
            NotificationListener<UserScrollNotification>(
                onNotification: (notificationInfo) {
                  if (notificationInfo.direction == ScrollDirection.forward) {
                    home.trueFabVisible();
                  } else if (notificationInfo.direction == ScrollDirection.reverse) {
                    home.falseFabVisible();
                  }
                  return true;
                },
                child: Container()
            )
          ],
        );
      }
    );
  }
}