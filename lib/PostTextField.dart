import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;

  const PostTextField({super.key, required this.controller, required this.hintText, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          )
      ),
      maxLines: null, // Allow multiple lines for the post
    );
  }
}
