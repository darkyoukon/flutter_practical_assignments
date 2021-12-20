import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';


class FutImages extends StatefulWidget {
  final List<String> chosenEntries;
  final int index;

  const FutImages(this.chosenEntries, this.index, {Key? key}) : super(key: key);

  @override
  State<FutImages> createState() => _FutImages();
}

class _FutImages extends State<FutImages> {
  late Future<List<String>> loadedImg;

  Future<List<String>> fetchDownloadedPicture() async {
    List<String> imgList = [];
    for(int index = 0; index < widget.chosenEntries.length; index++) {
      await Future.delayed(const Duration(milliseconds: 500), () async {
        final response = await http
            .get(Uri.parse('https://thispersondoesnotexist.com/image'));
        var documentDirectory = await getExternalStorageDirectory();
        var firstPath = documentDirectory!.path + "/images";
        var filePathAndName = documentDirectory.path + '/images/pic$index.jpeg';
        //comment out the next three lines to prevent the image from being saved
        //to the device to show that it's coming from the internet
        if (response.statusCode == 200) {
          await Directory(firstPath).create(recursive: true);
          File file = File(filePathAndName);
          file.writeAsBytesSync(response.bodyBytes);
          imgList.add(filePathAndName);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load source');
        }
      });
    }
    return imgList;
  }

  @override
  void initState() {
    super.initState();
    loadedImg = fetchDownloadedPicture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDownloadedPicture(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircleAvatar(
                  backgroundColor:
                  Color(Random().nextInt(0xffffffff)),
                  child: Text(widget.chosenEntries[widget.index]
                      .split(' ')
                      .map((e) => e = e[0])
                      .join()),
                  radius: 29);
            default:
              if (snapshot.hasError) {
                return CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: Text(widget.chosenEntries[widget.index]
                        .split(' ')
                        .map((e) => e = e[0])
                        .join()),
                    radius: 29);
              } else {
                List<String> imgSources =
                snapshot.data as List<String>;
                return CircleAvatar(
                    backgroundImage: Image.file(File(imgSources[widget.index])).image,
                    radius: 29);
              }
          }
        });
  }

}