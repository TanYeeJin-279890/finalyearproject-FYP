import 'package:flutter/material.dart';
import '../views/fix.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key, required this.backCategoryQuestion})
      : super(key: key);
  final VoidCallback backCategoryQuestion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: backCategoryQuestion,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: const Text(
          'BACK',
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
