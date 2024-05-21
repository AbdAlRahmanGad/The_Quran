import 'package:flutter/material.dart';
import 'package:the_quran/features/auth/view/page/athkarPage.dart';
import 'dart:convert';

class GeneralPage extends StatelessWidget {
  final List<String> jsonStrings; // List of JSON strings

  GeneralPage({required this.jsonStrings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الأذكار'),
      ),
      body: ListView.builder(
        itemCount: jsonStrings.length,
        itemBuilder: (context, index) {
          var jsonObject = jsonDecode(jsonStrings[index]);
          var title = jsonObject['title'];
          return ListTile(
            title: Text(title), // Display the title from the JSON string
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AthkarPage(
                    jsonString: jsonStrings[index], // Use the corresponding JSON string
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}