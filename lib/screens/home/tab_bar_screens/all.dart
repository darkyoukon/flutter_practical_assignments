
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

final List<String> entries = <String>['Saved Messages', 'Мама', 'Папа',
  'Любимая', 'Брат', 'Сестра',
  'Алла Ивановна', 'Павел Дуров',
  'Mark Zuckerberg', 'Deleted contact',
  'Test', 'test2', 'test3', 'test test'];
final List<int> rndState = entries.map((x) => Random().nextInt(4)).toList();
final List<int> rndMsgs = rndState.map((x) => x == 3 ? Random().nextInt(19)+1 : 0).toList();

class AllScreen extends StatefulWidget {

  AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _StateAllScreen();
}

class _StateAllScreen extends State<AllScreen> {
  ScrollController _scrollController = ScrollController();
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
    futImages = initImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: entries.length,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 56,
            padding: const EdgeInsets.only(top: 1, left: 9, right: 9, bottom: 1),

            child: Row(
              children: <Widget>[
                FutureBuilder(
                    future: futImages,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircleAvatar(
                                  backgroundColor: Color(Random().nextInt(0xffffffff)),
                                  child: Text(entries[index].split(' ').map((e) => e = e[0]).join()),
                                  radius: 29);
                        default:
                          if (snapshot.hasError) {
                            return CircleAvatar(
                                backgroundColor: Colors.brown.shade800,
                                child: Text(entries[index].split(' ').map((e) => e = e[0]).join()),
                                radius: 29);
                          } else {
                            List<String> imgSources = snapshot.data as List<String>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondRoute(imgtxt: imgSources[index], index: index))
                                );
                              },
                              child: Hero(
                                  tag: 'fullscreen$index',
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage(imgSources[index]),
                                      radius: 29)
                              ),
                            );
                          }
                      }
                    }
                ),
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
                                    child: Text(entries[index],
                                        style:
                                        const TextStyle(
                                            color: Color(0xffe9eef4),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          if(rndState[index] == 0) ...[
                                            Image.asset('assets/icons/widget_halfcheck.png', width: 14),
                                          ] else if(rndState[index] == 1) ...[
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: <Widget>[
                                                Positioned(
                                                  left: -5,
                                                  child: Image.asset('assets/icons/widget_halfcheck.png', width: 14),
                                                ),
                                                Image.asset('assets/icons/widget_check.png', width: 14)
                                              ],
                                            )
                                          ] else if(rndState[index] == 2) ...[
                                            Image.asset('assets/icons/widget_clock.png', width: 14)
                                          ] else ...[const SizedBox()],

                                          const Text('22:06',
                                              style: TextStyle(
                                                  color: Color(0xff717d88),
                                                  fontSize: 14))
                                        ]
                                    )
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('Привет, это я',
                                    style: TextStyle(
                                        color: Color(0xff7d8b99),
                                        fontSize: 16)),
                                if(rndState[index] > 2) ...[
                                  Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: rndMsgs[index] > 9 ? 32 : 23,
                                          height: 23,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Color(0xff64b5ef),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(Radius.circular(80)),
                                          ),
                                          child: Text((rndMsgs[index]).toString(), style: const TextStyle(fontWeight: FontWeight.bold))
                                      ),
                                    ],
                                  )
                                ] else if(index < 5) ...[
                                  Image.asset('assets/icons/widget_pin.png', width: 23),
                                ]
                              ]
                          ),
                          // const SizedBox(height:9),
                        ]
                    ),
                  ),
                ),
              ],
            )

          //Center(child: Text(entries[index])),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
          thickness: 0.6,
          indent: 74,
          color: Color(0xff11171e)
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  final String imgtxt;
  final int index;

  SecondRoute({required this.imgtxt, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'fullscreen$index',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imgtxt,
                    ),
                  ),
                ),
              ],
            ),
          ),
    ));
  }
}
