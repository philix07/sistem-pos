import 'package:flutter/material.dart';

class SpaceHeight extends StatelessWidget {
  const SpaceHeight(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
      );
}

class SpaceWidth extends StatelessWidget {
  const SpaceWidth(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
