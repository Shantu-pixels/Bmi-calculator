import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({ required this.colour, this.Customchild});

  final Color colour;
  final Widget? Customchild;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Customchild,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colour,
      ),
    );
  }
}