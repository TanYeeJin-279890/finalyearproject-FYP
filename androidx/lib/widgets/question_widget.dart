import 'package:androidx/views/fix.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.indexAction,
    required this.totalQuestions,
    required this.category,
  }) : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;
  final String category;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '${indexAction + 1}.) $question-$category',
        style: const TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
