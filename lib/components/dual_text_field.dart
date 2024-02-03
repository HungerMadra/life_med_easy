import 'package:flutter/material.dart';

class MyDualTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MyDualTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0), // Optional padding between dual text fields
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
