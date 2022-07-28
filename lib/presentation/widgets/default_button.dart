import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Color? color;
  final String title;
  final VoidCallback? function;

  const DefaultButton({
    Key? key,
    this.color = Colors.green,
    required this.title,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: color,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
