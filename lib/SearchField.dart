import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search for a country',
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: const Icon(Icons.search),
        ),
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
          onTap: onClear,
          child: const Icon(Icons.clear),
        )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}
