import 'package:flutter/material.dart';

class Admintextfeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;

  const Admintextfeild({
    super.key,
    required this.icon ,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration:InputDecoration(
                      hintText: '$hintText',
                      prefixIcon:icon,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow, width: 2),
                      ),
/*                       fillColor: Colors.white.withOpacity(0.8),
 */                      filled: true,
                    ),            
        validator: (value) => value!.isEmpty ? 'Please enter $hintText' : null,
      ),
    );
  }
  
}
