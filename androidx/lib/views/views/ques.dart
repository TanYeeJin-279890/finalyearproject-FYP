import 'dart:convert';

import 'package:androidx/views/models/category_model.dart';
import 'package:androidx/widgets/categoryquestion_widget.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../fix.dart';
import '../models/ques.dart';
import 'package:http/http.dart' as http;

//stateful widget being used as it will be our parent widget and the main functions and variables
//will be in this widget.
class QuesScreen extends StatefulWidget {
  const QuesScreen({Key? key}) : super(key: key);

  @override
  _QuesScreenState createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  // ignore: prefer_final_fields
  List<CategoryQuestion> _categories = [
    CategoryQuestion(id: '1', section: 'A', name: 'Verbal'),
    CategoryQuestion(id: '2', section: 'B', name: 'Social'),
    CategoryQuestion(id: '3', section: 'C', name: 'Narrative'),
    CategoryQuestion(id: '4', section: 'D', name: 'Spatial'),
    CategoryQuestion(id: '5', section: 'E', name: 'Kinesthetic'),
    CategoryQuestion(id: '6', section: 'F', name: 'Visual'),
    CategoryQuestion(id: '7', section: 'G', name: 'Mathematical/Scientific'),
    CategoryQuestion(id: '8', section: 'H', name: 'Musical')
  ];

  List<Question> questionList = <Question>[];
  String titlecenter = "Loading...";

  //index to loop through _categories
  int index = 0;
  bool btn = false;
  String category = "Verbal";

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadquestion(category);
    });
  }

  //function to display next category
  void nextCategoryQuestion() {
    if (index == _categories.length - 1 &&
        _categories[index].name == questionList[index].category) {
      return;
    } else {
      setState(() {
        index++; // when the index change to 1, rebuild the app.
      });
    }
  }

  //function to display previous category
  void backCategoryQuestion() {
    if (index == _categories.length - 1 &&
        _categories[index].name == questionList[index].category) {
      return;
    } else if (index == 0) {
      btn;
    } else {
      btn == true;
      setState(() {
        index--; // when the index change to 1, rebuild the app.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: neutral,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            actions: [
              Flexible(
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 100,
                  padding: const EdgeInsets.only(top: 19.0),
                  child: const Text(
                    'Dyslexic Evaluation Questions for Strengths and Weaknesses',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              )
            ],
            backgroundColor: background,
            shadowColor: Colors.transparent,
          ),
        ),
        body: questionList.isEmpty
            ? const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              )
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                //category
                                const SizedBox(height: 15.0),
                                CategoryQuestionWidget(
                                    category: _categories[index].name,
                                    indexAction: index, //currently at 0
                                    totalCategories: _categories.length),
                                //total length of the list
                                const Divider(
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              //first question widget
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${questionList[index].id}.) ${questionList[index].title.toString()}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    softWrap: true,
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(left: 30),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FloatingActionButton(
              onPressed: () => {
                category = _categories[index].name,
                backCategoryQuestion(),
                _loadquestion(category)
              },
              heroTag: '1',
              child: const Icon(Icons.navigate_before_rounded),
            ),
            FloatingActionButton(
              onPressed: () => {
                category = _categories[index].name,
                nextCategoryQuestion(),
                _loadquestion(category)
              },
              heroTag: '2',
              child: const Icon(Icons.navigate_next_rounded),
            ),
          ]),
        ));
  }

  void _loadquestion(String category) {
    http.post(Uri.parse(CONSTANTS.server + "/dys_server/php/load_ques.php"),
        body: {
          'category': category,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout Please retry again later";
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print("hello");
      print(category);
      print(response.body);
      var data = jsonDecode(response.body);

      print(data);
      if (response.statusCode == 200 && data['status'] == 'success') {
        var extractdata = data['data'];

        if (extractdata['question'] != null) {
          questionList = <Question>[];
          extractdata['question'].forEach((v) {
            questionList.add(Question.fromJson(v));
          });
          titlecenter = questionList.length.toString();
        } else {
          titlecenter = "No Question Posted";
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Question Posted";
        questionList.clear();
        setState(() {});
      }
    });
  }
}
