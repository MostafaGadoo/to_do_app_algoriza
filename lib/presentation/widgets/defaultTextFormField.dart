import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String validate;
  final TextEditingController? controller;
  final VoidCallback? function;
  final IconData? suffixIcon;
  final String text;
  const DefaultTextFormField({
    Key? key,
    required this.validate,
    required this.keyboardType,
    required this.controller,
    this.function,
    this.suffixIcon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validate;
        }
        return null;
      },
      keyboardType: keyboardType,
      onTap: function,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        disabledBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[100],
        hintText: text,
        suffixIcon: Icon(
            suffixIcon,
        ),
      ),

    );
  }
}
