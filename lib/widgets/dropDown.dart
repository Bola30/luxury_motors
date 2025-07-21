import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final Function(dynamic v)? onChanged;
  final String? hintText;

  const CustomDropDown({
    Key? key,
    this.value,
    required this.items,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: (value) => value == null ? 'Please select an option' : null,
      dropdownColor: Colors.white.withOpacity(0.8),
      value: value,
      isExpanded: true,
      isDense: true,
      icon: const Icon(Icons.arrow_circle_down_sharp, color: Colors.black),
      style: const TextStyle(color: Colors.black, fontSize: 16),
      hint: Text(
        hintText ?? 'Select an option',
        style: const TextStyle(color: Colors.black54, fontSize: 16),
      ),

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5) ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
