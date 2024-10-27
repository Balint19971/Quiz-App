import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/model/quiz_question.dart';
import 'package:quiz_app/view/choose_screen.dart';
import 'package:quiz_app/view/question_screen.dart';
import 'package:quiz_app/view/start_screen.dart';
import 'package:quiz_app/view/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  List<QuizQuestion> questions = [];
  List<String> options = [];
  String choosedOption = '';

  Future<void> readJson(String quizName) async {
    final String response =
        await rootBundle.loadString('assets/quiz_data.json');
    final data = await json.decode(response);
    List<String> responsesList = [];
    for (var questionData in data[quizName]) {
      for (var response in questionData['responses']) {
        responsesList.add(response.toString());
      }
      var question = QuizQuestion(
          questionData['text'], responsesList, questionData['correctAnswer']);
      questions.add(question);
      responsesList = [];
    }
  }

  Future<void> readJsonForInit() async {
    final String response =
        await rootBundle.loadString('assets/quiz_data.json');
    final Map<String, dynamic> data = await json.decode(response);
    setState(() {
      options = data.keys.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readJsonForInit();
  }

  var activeScreen = 'choose-screen';

  void switchScreenToQuestionScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void switchScreenToBeginStart(String option) {
    setState(() {
      readJson(option);
      choosedOption = option;
      activeScreen = 'start-screen';
    });
  }

  void switchScreenToStartScreen() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  void switchScreenToChooseScreen() {
    setState(() {
      questions = [];
      selectedAnswers = [];
      activeScreen = 'choose-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget = ChooseScreen(
        switchToBeginStart: switchScreenToBeginStart, options: options);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
        listOfQuestions: questions,
      );
    } else if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        switchScreenToStartScreen,
        switchScreenToChooseScreen,
        chosenAnswers: selectedAnswers,
        questions: questions,
      );
    } else if (activeScreen == 'start-screen') {
      screenWidget = StartScreen(switchScreenToQuestionScreen, switchScreenToChooseScreen, choosedOption);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.deepOrange
                // Color.fromARGB(255, 78, 13, 151),
                // Color.fromARGB(255, 107, 15, 168),
                // Color.fromARGB(255, 161, 175, 78),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
