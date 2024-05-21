import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_quran/features/dashboard/view/page/athkarPage.dart';

class GeneralPage extends StatelessWidget {
  final List<String> jsonStrings;

  GeneralPage({super.key, required this.jsonStrings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الأذكار'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: jsonStrings.length,
        itemBuilder: (context, index) {
          var jsonObject = jsonDecode(jsonStrings[index]);
          var title = jsonObject['title'];
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Text(title, style: const TextStyle(fontSize: 18.0)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AthkarPage(
                          jsonString: jsonStrings[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
