import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton(
      {super.key, required this.optionText, required this.onTap});

  final String optionText;
  final void Function() onTap;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      child: Text(
        optionText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
