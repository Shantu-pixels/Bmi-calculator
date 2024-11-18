import 'package:flutter/material.dart';



class containercontent extends StatelessWidget {
  const containercontent({
    super.key, required this.iconsss, required this.labeltext,
  });
  final IconData iconsss;
  final String labeltext;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconsss,
          size: 80,
        ),
        SizedBox(height: 15,),
        Text(labeltext,style: TextStyle(fontWeight:FontWeight.bold),),
      ],
    );
  }
}