import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Color color;
  final TextEditingController controller;
  final void Function(String) onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.color,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          filled: true,
          fillColor: color,
        ),
        onChanged: onChanged,
      )
    );
  }
}