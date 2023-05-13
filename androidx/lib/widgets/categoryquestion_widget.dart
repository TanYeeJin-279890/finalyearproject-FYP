import 'package:androidx/views/fix.dart';
import 'package:flutter/material.dart';

class CategoryQuestionWidget extends StatelessWidget {
  const CategoryQuestionWidget({
    Key? key,
    required this.category,
    required this.indexAction,
    required this.totalCategories,
  }) : super(key: key);

  final String category;
  final int indexAction;
  final int totalCategories;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Category ${indexAction + 1}/$totalCategories: $category',
        // ignore: prefer_const_constructors
        style: const TextStyle(
            fontSize: 24.0,
            color: background,
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
