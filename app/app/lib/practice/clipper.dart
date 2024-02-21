import 'dart:developer';

import 'package:flutter/material.dart';

class ClipperPractice extends StatelessWidget {
  const ClipperPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        height: 500,
        width: 500,
        color: Colors.amber,
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double raidus = 50;
    final path = Path();
    path.moveTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.circular(20));
    // path.lineTo(size.width, size.height);
    path.close();
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.close();

    // path.moveTo(0, size.height);
    // path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width, size.height);
    // path.cubicTo(size.width * .5, size.height * .4, size.width * .3,
    //     size.height, 0, size.height);
    // path.close();

    log(size.height.toString());
    log(size.width.toString());
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
