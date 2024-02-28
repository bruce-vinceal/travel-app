import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? iconData;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
        required this.labelText,
        required this.hintText,
        required this.iconData,
        required this.textInputType,
        required this.controller,
        this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: iconData != null
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(iconData),
            )
                : null,
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )
        ),
      validator: validator,
    );
  }
}
