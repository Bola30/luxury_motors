import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final bool obscureText;

  CustomTextField({
    required this.hintText,
    required this.icon,
      this.isPassword = false,
    required this.controller, required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(      
        validator: (value) => value!.isEmpty ? 'Please enter $hintText' : null,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow, width: 2),
          ),
          fillColor: Colors.white.withOpacity( 0.8),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: hintText,
          prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ));
  }
  
}