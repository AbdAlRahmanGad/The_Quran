import 'package:flutter/material.dart';

Widget indicator(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    height: 8,
    width: isActive ? 24 : 8,
    margin: EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: isActive ? Colors.blue : Colors.grey,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
