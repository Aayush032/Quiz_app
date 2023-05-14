import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final int indexaction;
  final int totalquestions;
  const QuestionWidget({
    super.key,
    required this.question,
    required this.indexaction,
    required this.totalquestions,
    });
  

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text("Question: ${indexaction+1}/$totalquestions: $question",
      style: const TextStyle(fontSize: 25,
      fontWeight: FontWeight.bold,
      color: neutral) ,
      ),
    );
  }
}