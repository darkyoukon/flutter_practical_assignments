import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_pa_telegram/screens/home/tab_screens/shared_prefs.dart';

import '../home_model.dart';
import 'img_builder.dart';

final List<String> chosenEntries = <String>[
  'Saved Messages',
  'Мама',
  'Папа',
  'Любимая',
  'Брат',
  'Сестра'
];

class FamilyScreen extends StatefulWidget {
  final int countIndex;

  const FamilyScreen(this.countIndex, {Key? key}) : super(key: key);

  @override
  State<FamilyScreen> createState() => _FamilyScreen();
}

class _FamilyScreen extends State<FamilyScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: chosenEntries.length,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              Provider.of<HomeModel>(context, listen: false).changeAppName(HomeModel.entries[index]);
            },
            child: Container(
                height: 56,
                padding:
                const EdgeInsets.only(top: 1, left: 9, right: 9, bottom: 1),
                child: Row(
                  children: <Widget>[
                    FutImages(chosenEntries, index),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11, right: 6),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 5,
                                        child: Text(chosenEntries[index],
                                            style: TextStyle(
                                                color: Provider.of<SharedPrefs>(context).getTheme
                                                    ? const Color(0xffe9eef4)
                                                    : const Color(0xff1e1e1e),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              if (HomeModel.rndState[
                                              HomeModel.entries.indexOf(
                                                  chosenEntries[index])] ==
                                                  0) ...[
                                                Provider.of<SharedPrefs>(context).getTheme
                                                    ? Image.asset(
                                                    'assets/icons/widget_halfcheck.png',
                                                    width: 14)
                                                    : Image.asset(
                                                    'assets/icons/widget_halfcheck_green.png',
                                                    width: 14)
                                              ] else if (HomeModel.rndState[
                                              HomeModel.entries.indexOf(
                                                  chosenEntries[index])] ==
                                                  1) ...[
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: <Widget>[
                                                    Positioned(
                                                      left: -5,
                                                      child: Provider.of<SharedPrefs>(context).getTheme
                                                          ? Image.asset(
                                                          'assets/icons/widget_halfcheck.png',
                                                          width: 14)
                                                          : Image.asset(
                                                          'assets/icons/widget_halfcheck_green.png',
                                                          width: 14),
                                                    ),
                                                    Provider.of<SharedPrefs>(context).getTheme
                                                        ? Image.asset(
                                                        'assets/icons/widget_check.png',
                                                        width: 14)
                                                        : Image.asset(
                                                        'assets/icons/widget_check_green.png',
                                                        width: 14)
                                                  ],
                                                )
                                              ] else if (HomeModel.rndState[
                                              HomeModel.entries.indexOf(
                                                  chosenEntries[index])] ==
                                                  2) ...[
                                                Image.asset(
                                                    'assets/icons/widget_clock.png',
                                                    width: 14)
                                              ] else ...[
                                                const SizedBox()
                                              ],
                                              const Text('22:06',
                                                  style: TextStyle(
                                                      color: Color(0xff717d88),
                                                      fontSize: 14))
                                            ]))
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text('Привет, это я',
                                        style: TextStyle(
                                            color: Color(0xff7d8b99),
                                            fontSize: 16)),
                                    if (HomeModel.rndState[HomeModel.entries
                                        .indexOf(chosenEntries[index])] >
                                        2) ...[
                                      Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: widget.countIndex +
                                                  HomeModel.rndMsgs[HomeModel
                                                      .entries
                                                      .indexOf(
                                                      chosenEntries[
                                                      index])] >
                                                  9
                                                  ? 32
                                                  : 23,
                                              height: 23,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: Color(0xff64b5ef),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(80)),
                                              ),
                                              child: Text(
                                                  (widget.countIndex +
                                                      HomeModel.rndMsgs[HomeModel
                                                          .entries
                                                          .indexOf(
                                                          chosenEntries[index])])
                                                      .toString(),
                                                  style: const TextStyle(fontWeight: FontWeight.bold))),
                                        ],
                                      )
                                    ] else if (index < 5) ...[
                                      Image.asset('assets/icons/widget_pin.png',
                                          width: 23),
                                    ]
                                  ]),
                              // const SizedBox(height:9),
                            ]),
                      ),
                    ),
                  ],
                )

              //Center(child: Text(entries[index])),
            )
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(thickness: 0.6, indent: 74, color: Provider.of<SharedPrefs>(context).getTheme
              ? const Color(0xff11171e)
              : const Color(0xffe8e8e8)),
    );
  }
}
