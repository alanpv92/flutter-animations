import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({super.key});

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with TickerProviderStateMixin {
  late AnimationController step1Controller;
  late AnimationController step2Controller;
  late Animation step1Animation;
  late Animation step2Animation;
  @override
  void initState() {
    step1Controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    step2Controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    step1Animation = Tween<double>(begin: 0, end: pi / 2).animate(
        CurvedAnimation(parent: step1Controller, curve: Curves.bounceOut));
    step2Animation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: step2Controller, curve: Curves.bounceOut));

    step1Controller.forward();
    step1Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        step2Controller.forward();
      }
    });

    step2Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        step1Controller.reset();
        step2Controller.reset();
        step1Controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    step1Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: step2Controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.topCenter,
            transform: Matrix4.identity()..rotateY(step2Animation.value),
            child: AnimatedBuilder(
              animation: step1Controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: step1Animation.value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipPath(
                        clipper: CircleLeftClipper(),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: CircleRightClipper(),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

class CircleLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: const Radius.circular(20), clockwise: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CircleRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..arcToPoint(
        Offset(0, size.height),
        radius: const Radius.circular(20),
      )
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
