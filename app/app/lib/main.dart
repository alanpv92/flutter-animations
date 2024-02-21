import 'package:app/animated_circle.dart';
import 'package:app/practice/clipper.dart';
import 'package:app/spining_container.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Center(
          child: AnimatedCircle(),
        )),
      ),
    );
  }
}

