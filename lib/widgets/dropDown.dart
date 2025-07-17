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
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
