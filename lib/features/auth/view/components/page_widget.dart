import 'package:flutter/widgets.dart';

Widget _buildPage(
    {required String title,
    required String description,
    required String image}) {
  return Container(
    padding: EdgeInsets.all(20),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          description,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Image.asset(
          image,
          height: 200,
        ),
      ],
    ),
  );
}
