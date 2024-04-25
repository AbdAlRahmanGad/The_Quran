import 'package:flutter/widgets.dart';

Widget _buildPage(
    {required String title,
    required String description,
    required String image}) {
  return Container(
    padding: const EdgeInsets.all(20),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset(
          image,
          height: 200,
        ),
      ],
    ),
  );
}
