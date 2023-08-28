// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../component/variable.dart';

class Home extends StatelessWidget {

  static String id = 'Home';
  String text;

 Home({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(text),
      ]),
    );
  }
}
