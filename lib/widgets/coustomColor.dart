import 'package:flutter/material.dart';


class PickColor extends StatelessWidget {
  final Color color;

  const PickColor({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
  
  
}