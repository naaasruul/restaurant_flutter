import 'package:flutter/material.dart';

InputDecoration kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  iconColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey[600]),
  prefixIconColor: Colors.lightBlueAccent,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 0, color: Colors.white)),
);

const kBoxDecoration = BoxDecoration(
    image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/images/background.jpg',
        )));
