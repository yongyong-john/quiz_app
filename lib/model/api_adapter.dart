import 'dart:convert';
import 'package:quiz_app/model/quiz_model.dart';

List<Quiz> parseQuizs(String reponseBody) {
  final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
  return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
}
