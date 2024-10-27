import 'package:flutter/material.dart';
import 'package:quiz_app/widget/option_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({
    Key? key, // Change super.key to Key? key
    required this.switchToBeginStart,
    required this.options,
  }) : super(key: key); // Update super.key

  final void Function(String option) switchToBeginStart;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose a theme for your quiz",
              style: GoogleFonts.lato(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...options.map((option) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: OptionButton(
                  optionText: option,
                  onTap: () {
                    switchToBeginStart(option);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
