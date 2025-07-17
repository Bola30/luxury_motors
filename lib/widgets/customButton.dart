import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color ; // Default color

  CustomButton({
    required this.text,
    required this.onPressed, required this.color, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: double.infinity, // Make the button full width
        child: ElevatedButton(
          
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }


}