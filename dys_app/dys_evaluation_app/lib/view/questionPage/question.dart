import 'dart:convert';

import 'package:dys_evaluation_app/models/ques.dart';
import 'package:dys_evaluation_app/models/reg.dart';
import 'package:dys_evaluation_app/view/resultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../../fix.dart';
import '../../models/category_model.dart';
import '../../models/ques.dart';
import '../../widgets/category_question.dart';

//stateful widget being used as it will be our parent widget and the main functions and variables
//will be in this widget.
class QuesScreen extends StatefulWidget {
  final Registration reg;
  final String name;
  final String age;
  const QuesScreen(
      {Key? key, required this.reg, required this.name, required this.age})
      : super(key: key);

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

  List<int> ttlmarks = [0, 0, 0, 0, 0, 0, 0, 0];
  List<double> _newList = [1, 1, 1, 1, 1];

  List<double> _verbalScoreList = [1, 1, 1, 1, 1];
  List<double> _socialScoreList = [1, 1, 1, 1, 1];
  List<double> _narrativeScoreList = [1, 1, 1, 1, 1];
  List<double> _spatialScoreList = [1, 1, 1, 1, 1];
  List<double> _kinestheticScoreList = [1, 1, 1, 1, 1];
  List<double> _visualScoreList = [1, 1, 1, 1, 1];
  List<double> _mathsciScoreList = [1, 1, 1, 1, 1];
  List<double> _musicalScoreList = [1, 1, 1, 1, 1];
  int totalmarks = 0;

  //index to loop through _categories
  int index = 0;
  bool btn = false;
  String category = "Verbal";
  String _status = 'Not Accurate At All';
  Color _statusColor = Colors.black;
  int _currentSliderValue = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadquestion(category);
    });
  }

  //function to display next category
  void nextCategoryQuestion() {
    if (index == _categories.length - 1) {
      return;
    } else if (index > _categories.length - 1) {
      btn;
    } else {
      btn == true;
      setState(() {
        index++; // when the index change to 1, rebuild the app.
      });
    }
  }

  //function to display previous category
  void backCategoryQuestion() {
    if (index == _categories.length - 1) {
      return;
    } else if (index < 0) {
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
                padding: const EdgeInsets.only(top: 19.0, left: 20.0),
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
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Expanded(
                  child: Column(
                    children: [
                      //category name
                      const SizedBox(height: 5.0),
                      CategoryQuestionWidget(
                          category: _categories[index].name,
                          indexAction: index, //currently at 0
                          totalCategories: _categories.length),
                      const Divider(
                        color: Colors.black,
                      ),
                      Expanded(
                          child: GridView.count(
                        controller: _scrollController,
                        crossAxisCount: 1,
                        childAspectRatio: (1 / 0.7),
                        children: List.generate(questionList.length, (index) {
                          return InkWell(
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Text(
                                              "${questionList[index].section}.) ${questionList[index].title.toString()}",
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Slider(
                                                value: _newList[index],
                                                min: 1,
                                                max: 5,
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        3, 164, 255, 1),
                                                inactiveColor:
                                                    const Color.fromRGBO(
                                                            3, 164, 255, 1)
                                                        .withOpacity(0.3),
                                                thumbColor:
                                                    const Color.fromRGBO(
                                                        3, 164, 255, 1),
                                                label: _currentSliderValue
                                                    .round()
                                                    .toString(),
                                                divisions: 4,
                                                onChanged: (double value) {
                                                  _newList[index] = value;
                                                  setState(() {
                                                    _currentSliderValue =
                                                        value.toInt();

                                                    //Add value in category marks array
                                                    storeCategoryMarks(
                                                        category);

                                                    //total up marks and store in array
                                                    var sum = _newList.reduce(
                                                        (previous, current) =>
                                                            previous + current);

                                                    storeTotalMarks(
                                                        category, sum.toInt());

                                                    if (value == 1) {
                                                      _status =
                                                          'Not Accurate At All ($value)';
                                                      _statusColor =
                                                          Colors.black;
                                                    } else if (value == 2) {
                                                      _status =
                                                          'Slightly Accurate ($value)';
                                                      _statusColor =
                                                          Colors.black;
                                                    } else if (value == 3) {
                                                      _status =
                                                          'Moderately Accurate ($value)';
                                                      _statusColor =
                                                          Colors.black;
                                                    } else if (value == 4) {
                                                      _status =
                                                          'Very Accurate ($value)';
                                                      _statusColor =
                                                          Colors.black;
                                                    } else if (value == 5) {
                                                      _status =
                                                          'Extremely Accurate ($value)';
                                                      _statusColor =
                                                          Colors.black;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Status: $_status',
                                              style: TextStyle(
                                                color: _statusColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ))
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    height: 50,
                    child: index == category.length
                        //submit button
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                FloatingActionButton.extended(
                                  onPressed: () => {
                                    setState(() {
                                      ttlmarks = ttlmarks;
                                    }),
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ResultPage(
                                                  reg: widget.reg,
                                                  ttlmarks: ttlmarks,
                                                  name: widget.name,
                                                  age: widget.age,
                                                )))
                                  },
                                  heroTag: '3',
                                  label: const Text('Submit'),
                                  icon: const Icon(Icons.navigate_next_rounded),
                                  backgroundColor: submitbtn,
                                ),
                              ])
                        //back and next button
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                _categories[index].name == "Verbal"
                                    //without back button
                                    ? Row(
                                        children: [
                                          FloatingActionButton.extended(
                                            onPressed: () => {
                                              category =
                                                  _categories[index + 1].name,
                                              if (ttlmarks[index].toInt() != 0)
                                                {_printMarks(category)}
                                              else
                                                {
                                                  _newList[0] = 1,
                                                  _newList[1] = 1,
                                                  _newList[2] = 1,
                                                  _newList[3] = 1,
                                                  _newList[4] = 1,
                                                },
                                              nextCategoryQuestion(),
                                              _loadquestion(category),
                                              storeCategoryMarks(category),
                                              _scrollController.animateTo(0,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease)
                                            },
                                            heroTag: '4',
                                            label: const Text('Next'),
                                            icon: const Icon(
                                              Icons.navigate_next_rounded,
                                            ),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    3, 164, 255, 1),
                                          ),
                                        ],
                                      )
                                    //with back button
                                    : Row(
                                        children: [
                                          Row(
                                            children: [
                                              FloatingActionButton.extended(
                                                onPressed: () => {
                                                  category =
                                                      _categories[index - 1]
                                                          .name,
                                                  backCategoryQuestion(),
                                                  _loadquestion(category),
                                                  _printMarks(category),
                                                },
                                                heroTag: '1',
                                                label: const Text('Back'),
                                                icon: const Icon(Icons
                                                    .navigate_before_rounded),
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        3, 164, 255, 1),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 150),
                                          Row(
                                            children: [
                                              FloatingActionButton.extended(
                                                onPressed: () => {
                                                  category =
                                                      _categories[index + 1]
                                                          .name,
                                                  if (ttlmarks[index].toInt() !=
                                                      0)
                                                    {_printMarks(category)}
                                                  else
                                                    {
                                                      _newList[0] = 1,
                                                      _newList[1] = 1,
                                                      _newList[2] = 1,
                                                      _newList[3] = 1,
                                                      _newList[4] = 1,
                                                    },
                                                  nextCategoryQuestion(),
                                                  _loadquestion(category),
                                                  storeCategoryMarks(category),
                                                  _scrollController.animateTo(0,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.ease)
                                                },
                                                heroTag: '2',
                                                label: const Text('Next'),
                                                icon: const Icon(
                                                  Icons.navigate_next_rounded,
                                                ),
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        3, 164, 255, 1),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                              ]))
              ]),
            ),
    );
  }

  void _printMarks(String category) {
    if (category == "Verbal") {
      print("$category marks");
      _newList = List.from(_verbalScoreList);
    } else if (category == "Social") {
      print("$category marks");
      _newList = List.from(_socialScoreList);
    } else if (category == "Narrative") {
      print("$category marks");
      _newList = List.from(_narrativeScoreList);
    } else if (category == "Spatial") {
      print("$category marks");
      _newList = List.from(_spatialScoreList);
    } else if (category == "Kinesthetic") {
      print("$category marks");
      _newList = List.from(_kinestheticScoreList);
    } else if (category == "Visual") {
      print("$category marks");
      _newList = List.from(_visualScoreList);
    } else if (category == "Mathematical/Scientific") {
      print("$category marks");
      _newList = List.from(_mathsciScoreList);
    } else if (category == "Musical") {
      print("$category marks");
      _newList = List.from(_musicalScoreList);
    }
  }

  void storeCategoryMarks(String category) {
    if (category == "Verbal") {
      print("Hi $category marks");
      _verbalScoreList = List.from(_newList);
      print(_verbalScoreList);
    } else if (category == "Social") {
      print("$category marks");
      _socialScoreList = List.from(_newList);
    } else if (category == "Narrative") {
      print("$category marks");
      _narrativeScoreList = List.from(_newList);
    } else if (category == "Spatial") {
      print("$category marks");
      _spatialScoreList = List.from(_newList);
    } else if (category == "Kinesthetic") {
      print("$category marks");
      _kinestheticScoreList = List.from(_newList);
    } else if (category == "Visual") {
      print("$category marks");
      _visualScoreList = List.from(_newList);
    } else if (category == "Mathematical/Scientific") {
      print("$category marks");
      _mathsciScoreList = List.from(_newList);
    } else if (category == "Musical") {
      print("$category marks");
      _musicalScoreList = List.from(_newList);
    }
  }

  void storeTotalMarks(String category, int marks) {
    //calculate totalmarks of each category
    if (_categories[index].name == category) {
      int ttl = marks;
      ttlmarks[index] = ttl;
      print("Totalmarks: ");
      print(ttlmarks);
    } else if (_categories[index].name != category) {
      print("Category Problem");
      print(category);
      print(_categories[index].name);
    } else {
      print(category);
      print("Nothing");
      print(_categories[index + 1].name);
    }
  }

  void _loadquestion(String category) {
    http.post(Uri.parse("${CONSTANTS.server}/dys_server/php/load_ques.php"),
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
      var data = jsonDecode(response.body);

      print(_categories[index].name);
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
