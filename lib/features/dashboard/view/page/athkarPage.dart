import 'dart:convert';

import 'package:flutter/material.dart';

class Zekr {
  final String title;
  final List<Content> content;

  Zekr({required this.title, required this.content});

  factory Zekr.fromJson(Map<String, dynamic> json) {
    var contentFromJson = json['content'] as List;
    List<Content> contentList =
        contentFromJson.map((i) => Content.fromJson(i)).toList();

    return Zekr(
      title: json['title'],
      content: contentList,
    );
  }
}

class Content {
  String zekr;
  int repeat;
  final String bless;

  Content({required this.zekr, required this.repeat, required this.bless});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      zekr: json['zekr'],
      repeat: json['repeat'],
      bless: json['bless'],
    );
  }
}

class AthkarPage extends StatefulWidget {
  final String jsonString;

  const AthkarPage({super.key, required this.jsonString});

  @override
  _AthkarPageState createState() => _AthkarPageState();
}

class _AthkarPageState extends State<AthkarPage> {
  late Zekr zekr;

  @override
  void initState() {
    super.initState();

    zekr = Zekr.fromJson(jsonDecode(widget.jsonString));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(zekr.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: zekr.content.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (zekr.content[index].repeat > 0) {
                setState(() {
                  zekr.content[index].repeat--;
                });
              }
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(zekr.content[index].zekr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      'التكرار: ${zekr.content[index].repeat}\nالفضل: ${zekr.content[index].bless}',
                      style: TextStyle(color: Colors.grey[700])),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
