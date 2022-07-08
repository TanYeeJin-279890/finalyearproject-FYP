import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constant.dart';
import '../models/tutorDetails.dart';
import '../models/tutor.dart';

class TutorPage extends StatefulWidget {
  //final Tutor tutor;
  const TutorPage({Key? key}) : super(key: key);

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  List<Tutor> tutorList = <Tutor>[];
  String titlecenter = "Loading...";
  TextEditingController searchController = TextEditingController();
  String search = "";
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat.yMd();
  var numofpage, curpage = 1;
  var color;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadTutors(1, search);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Awesome Tutors',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
        ],
      ),
      body: tutorList.isEmpty
          ? const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            )
          : Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(tutorList.length, (index) {
                        return InkWell(
                          splashColor: Colors.blue,
                          onTap: () => {_loadTutorDetails(index)},
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/mytutor_mp_server/mobile/resources/tutors/" +
                                          tutorList[index].tutorId.toString() +
                                          '.jpg',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            border: const Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fitHeight,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.white,
                                                      BlendMode.colorBurn),
                                            )),
                                      ),
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Text(
                                    tutorList[index].tutorName.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                  Flexible(
                                      flex: 4,
                                      child: ListView(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Column(children: [
                                                  Text(
                                                    "\nEmail: " +
                                                        tutorList[index]
                                                            .tutorEmail
                                                            .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    "Phone: " +
                                                        tutorList[index]
                                                            .tutorPhone
                                                            .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              )),
                        );
                      }))),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadTutors(index + 1, "")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  void _loadTutors(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(
            CONSTANTS.server + "/mytutor_mp_server/mobile/php/load_tutor.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout Please retry again later";
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var data = jsonDecode(response.body);

      print(data);
      if (response.statusCode == 200 && data['status'] == 'success') {
        var extractdata = data['data'];
        numofpage = int.parse(data['numofpage']);

        if (extractdata['tutors'] != null) {
          tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
          titlecenter = tutorList.length.toString() + " Tutors Available";
        } else {
          titlecenter = "No Tutor Available";
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Tutor Available";
        tutorList.clear();
        setState(() {});
      }
    });
  }

  void _loadSearchDialog() {
    searchController.text = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search",
                ),
                content: SizedBox(
                  //height: screenHeight / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchController.text;
                      Navigator.of(context).pop();
                      _loadTutors(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

  _loadTutorDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Tutor Details",
              style: TextStyle(),
            ),
            content: SizedBox(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor_mp_server/mobile/resources/tutors/" +
                      tutorList[index].tutorId.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  tutorList[index].tutorName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "\nAbout Me: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(tutorList[index].tutorDesc.toString(),
                      style: const TextStyle(fontSize: 16)),
                  const Text(
                    "\nRegistered Date: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      df.format(DateTime.parse(
                          tutorList[index].tutorDateReg.toString())),
                      style: const TextStyle(fontSize: 16)),
                  const Text(
                    "\nSubject Handle: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(tutorList[index].subjectshandle.toString(),
                      style: const TextStyle(fontSize: 16)),
                ]),
              ],
            )),
          );
        });
  }
}
