import 'package:flutter/material.dart';

import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int totalScore = 0;

  void userAns(bool userAnswer) {
    bool correctAns = quizbrain.getCorrectAns();
    setState(() {
      if (quizbrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Completed',
          desc:
              'You have complete the all of question, Your Score: $totalScore',
        ).show();

        scoreKeeper = [];
        totalScore = 0;
        quizbrain.reset();
      } else if (correctAns == userAnswer) {
        totalScore += 10;
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });
    quizbrain.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                userAns(true);
              },
              icon: Icon(Icons.check),
              label: Text(
                'TRUE',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                userAns(false);
              },
              icon: Icon(Icons.close),
              label: Text(
                'FALSE',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
