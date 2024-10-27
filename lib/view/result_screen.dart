import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_question.dart';
import 'package:quiz_app/widget/questions_result.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.backToStartScreen, this.backToChooseScreen,
      {super.key, required this.chosenAnswers, required this.questions});

  final List<String> chosenAnswers;
  final void Function() backToStartScreen;
  final void Function() backToChooseScreen;
  final List<QuizQuestion> questions;

  List<Map<String, Object>> getResult() {
    final List<Map<String, Object>> result = [];

    for (int i = 0; i < chosenAnswers.length; i++) {
      result.add(
        {
          'question_index': i + 1,
          'question': questions[i].text,
          'correct_answer': questions[i].correctAnswer,
          'user_answer': chosenAnswers[i],
        },
      );
    }

    return result;
  }

  @override
  Widget build(context) {
    final result = getResult();
    final totalQuestions = chosenAnswers.length;
    final correctAnswers = result.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correctly answerd questions: $correctAnswers out of $totalQuestions',
              style: GoogleFonts.lato(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsResult(result: getResult()),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: backToStartScreen,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart Quiz'),
            ),
            OutlinedButton.icon(
              onPressed: backToChooseScreen,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.arrow_circle_left),
              label: const Text('Go Back'),
            )
          ],
        ),
      ),
    );
  }
}
