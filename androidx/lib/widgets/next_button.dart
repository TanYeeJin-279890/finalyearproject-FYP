import 'package:flutter/material.dart';
import '../views/fix.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.nextCategoryQuestion})
      : super(key: key);
  final VoidCallback nextCategoryQuestion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextCategoryQuestion,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: const Text(
          'NEXT',
          style: TextStyle(
              color: neutral,
              fontSize: 20.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
