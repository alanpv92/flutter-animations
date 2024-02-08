import 'dart:math';

import 'package:flutter/material.dart';

class SpiningContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Matrix4? matrix4;
  final Alignment? alignment;
  const SpiningContainer(
      {super.key, this.color, this.height, this.matrix4, this.width,this.alignment});

  @override
  State<SpiningContainer> createState() => _SpiningContainerState();
}

class _SpiningContainerState extends State<SpiningContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Container(
        height: widget.height ?? 100,
        width: widget.width ?? 100,
        decoration: BoxDecoration(
          color: widget.color ?? Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      builder: (context, child) {
        return Transform(
            alignment:widget.alignment?? Alignment.center,
            transform: widget.matrix4 ?? Matrix4.identity()
              ..rotateZ(_animation.value),
            child: child);
      },
    );
  }
}
