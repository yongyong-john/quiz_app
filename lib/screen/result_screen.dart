import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/screen/home_screen.dart';

class ResultScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;

  ResultScreen({super.key, required this.answers, required this.quizs});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    int score = 0;
    List.generate(
      quizs.length,
      (index) => quizs[index].answer == answers[index] ? score += 1 : score,
    );

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.deepPurple,
              ),
              width: width * 0.85,
              height: height * 0.5,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: width * 0.048)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white,
                    ),
                    width: width * 0.73,
                    height: height * 0.28,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, width * 0.048, 0, width * 0.012),
                          child: Text(
                            '수고하셨습니다!',
                            style: TextStyle(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '당신의 점수는',
                          style: TextStyle(
                            fontSize: width * 0.048,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          '${score.toString()}/${quizs.length.toString()}',
                          style: TextStyle(
                            fontSize: width * 0.21,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * 0.012),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                    child: SizedBox(
                      width: width * 0.73,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('홈으로 돌아가기'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
