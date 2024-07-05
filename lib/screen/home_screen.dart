import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/api_adapter.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/screen/quiz_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  List<Quiz> quizs = [
    //   Quiz.fromMap({
    //     'title': 'test',
    //     'candidates': ['a', 'b', 'c', 'd'],
    //     'answer': 0,
    //   }),
    //   Quiz.fromMap({
    //     'title': 'test',
    //     'candidates': ['a', 'b', 'c', 'd'],
    //     'answer': 0,
    //   }),
    //   Quiz.fromMap({
    //     'title': 'test',
    //     'candidates': ['a', 'b', 'c', 'd'],
    //     'answer': 0,
    //   })
  ];
  bool isLoading = false;

  _fetchQuizs() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      setState(() {
        quizs = parseQuizs(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load quizs');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    print('Size: width=$width, height=$height');

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              "My Quiz App",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'images/quiz.jpeg',
                  width: width * 0.8,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.024),
              ),
              Text(
                '플러터 퀴즈 앱',
                style: TextStyle(
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '퀴즈를 풀기 전 안내사항입니다.\n꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.048),
              ),
              _buildStep(width, '1. 랜덤으로 나오는 퀴즈 3개를 풀어보세요.'),
              _buildStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤\n다음 문제 버튼을 눌러주세요.'),
              _buildStep(width, '3. 만점을 향해 도전해보세요!'),
              Padding(
                padding: EdgeInsets.all(width * 0.048),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: width * 0.036),
                  child: Center(
                    child: SizedBox(
                      width: width * 0.8, // 버튼의 가로 길이 설정
                      child: ElevatedButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Row(
                              children: [
                                const CircularProgressIndicator(),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.036),
                                ),
                                const Text('로딩 중...'),
                              ],
                            ),
                          ));
                          _fetchQuizs().whenComplete(() {
                            return Navigator.push(
                                context, MaterialPageRoute(builder: (context) => QuizScreen(quizs: quizs)));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          minimumSize: Size.fromHeight(height * 0.05), // 버튼의 최소 높이 설정
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('지금 퀴즈 풀기'),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.048,
        width * 0.024,
        width * 0.048,
        width * 0.024,
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.024),
          ),
          Text(title),
        ],
      ),
    );
  }
}
