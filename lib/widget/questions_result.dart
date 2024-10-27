import 'package:flutter/material.dart';

class QuestionsResult extends StatelessWidget {
  const QuestionsResult({super.key, required this.result});

  final List<Map<String, Object>> result;

  Color getColor(String correctAnswer, String userAnswer) {
    if (correctAnswer == userAnswer) {
      return const Color.fromARGB(255, 43, 204, 70);
    }

    return const Color.fromARGB(255, 255, 0, 43);
  }

  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: result.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: getColor(data['correct_answer'] as String,
                        data['user_answer'] as String),
                  ),
                  child: Center(
                    child: Text(
                      (data['question_index'] as int).toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['question'] as String,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 253, 124)),
                        data['correct_answer'] as String,
                      ),
                      Text(data['user_answer'] as String),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
