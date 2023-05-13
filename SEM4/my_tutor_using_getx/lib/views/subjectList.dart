import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_tutor/constant.dart';
import 'package:my_tutor/models/reg.dart';
import '../models/cart.dart';
import '../models/subject.dart';
import 'cartscreen.dart';
import 'user_registration.dart';
import 'userlogin.dart';

class SubjectList extends StatefulWidget {
  final Registration reg;
  const SubjectList({Key? key, required this.reg}) : super(key: key);

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  List<Subject> subjectList = <Subject>[];
  List<Cart> cart = <Cart>[];
  String titlecenter = "Loading...";
  late double screenHeight, screenWidth, resWidth;
  var numofpage, cartqty, curpage = 1;
  var color;
  TextEditingController searchController = TextEditingController();
  String search = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadSubjects(1, search);
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
        title: const Text(
          'Awesome Courses',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
          TextButton.icon(
            onPressed: () async {
              if (widget.reg.email == "guest@slumberjer.com") {
                _loadOptions();
              } else {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => CartScreen(
                              reg: widget.reg,
                            )));
                _loadSubjects(1, search);
                _loadMyCart();
              }
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(widget.reg.cart.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: subjectList.isEmpty
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
                      children: List.generate(subjectList.length, (index) {
                        return InkWell(
                            splashColor: Colors.red,
                            onTap: () => {_loadSubjectDetails(index)},
                            child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(children: [
                                  Flexible(
                                    flex: 5,
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/mytutor_mp_server/mobile/resources/courses/" +
                                          subjectList[index]
                                              .subjectId
                                              .toString() +
                                          '.png',
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    subjectList[index].subjectName.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        3.0, 2.0, 3.0, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "Rating: " +
                                                subjectList[index]
                                                    .subjectRating
                                                    .toString(),
                                            textScaleFactor: 1,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "Price: RM" +
                                                subjectList[index]
                                                    .subjectPrice
                                                    .toString(),
                                            textScaleFactor: 1,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        3.0, 2.0, 3.0, 2.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "Session: " +
                                                subjectList[index]
                                                    .subjectSessions
                                                    .toString(),
                                            textScaleFactor: 1,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: IconButton(
                                                onPressed: () {
                                                  _addtocartDialog(index);
                                                },
                                                icon: const Icon(
                                                    Icons.shopping_cart))),
                                      ],
                                    ),
                                  ),
                                ])));
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
                          onPressed: () => {_loadSubjects(index + 1, "")},
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

  void _loadSubjects(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server +
            "/mytutor_mp_server/mobile/php/load_subject.php"),
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
      print(response.body);
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['subjects'] != null) {
          subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subject.fromJson(v));
          });
          titlecenter = subjectList.length.toString() + " Subjects Available";
        } else {
          titlecenter = "No Subject Available";
          subjectList.clear();
        }
        setState(() {});
      } else {
        titlecenter = "No Subject Available";
        subjectList.clear();
        setState(() {});
      }
    });
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search your intended subjects name',
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
                      _loadSubjects(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

  _loadSubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Courses Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor_mp_server/mobile/resources/courses/" +
                      subjectList[index].subjectId.toString() +
                      '.png',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  subjectList[index].subjectName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("\nSubject Description: \n" +
                      subjectList[index].subjectDescription.toString()),
                  Text("\nPrice: RM " +
                      double.parse(subjectList[index].subjectPrice.toString())
                          .toStringAsFixed(2)),
                  Text("\nTotal Sessions: " +
                      subjectList[index].subjectSessions.toString() +
                      " classes"),
                  Text("\nRatings: " +
                      subjectList[index].subjectRating.toString()),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 60,
                    width: 1000,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        _addtocartDialog(index);
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text(
                        "Add to Cart",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
              ],
            )),
          );
        });
  }

  _loadOptions() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Please select",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: _onLogin, child: const Text("Login")),
                ElevatedButton(
                    onPressed: _onRegister, child: const Text("Register")),
              ],
            ),
          );
        });
  }

  _addtocartDialog(int index) {
    if (widget.reg.email == "guest@slumberjer.com") {
      _loadOptions();
    } else {
      //_confirmationDialog(index);
    }
  }

  void _onLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const LoginPage()));
  }

  void _onRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const RegisterPage()));
  }

  void _loadMyCart() {
    if (widget.reg.email != "guest@slumberjer.com") {
      http.post(
          Uri.parse(CONSTANTS.server +
              "/mytutor_mp_server/mobile/php/load_cartqty.php"),
          body: {
            "email": widget.reg.email.toString(),
          }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      ).then((response) {
        print(response.body);
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          print(jsondata['data']['carttotal'].toString());
          setState(() {
            widget.reg.cart = jsondata['data']['carttotal'].toString();
          });
        }
      });
    }
  }

  void getqty(int index) {
    String subid;
    http.post(
          Uri.parse(
              CONSTANTS.server + "/mytutor_mp_server/mobile/php/insert_cart.php"),
          body: {"subjectId": subid, "password": _password}).then((response) {
        print(response.body);
  });

  // void _confirmationDialog(int index) {
  //   index = int.parse(subjectList[index].subjectId.toString());
  //   var qty = int.parse(cart[index].cartqty.toString());
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         if (qty > 1) {
  //           return AlertDialog(
  //             shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //             title: const Text(
  //               "Subject has been added to the cart",
  //               style: TextStyle(),
  //             ),
  //             content:
  //                 const Text("Are you sure to add again?", style: TextStyle()),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: const Text(
  //                   "Yes",
  //                   style: TextStyle(),
  //                 ),
  //                 onPressed: () async {
  //                   Navigator.of(context).pop();
  //                   _addtoCart(index);
  //                 },
  //               ),
  //               TextButton(
  //                 child: const Text(
  //                   "No",
  //                   style: TextStyle(),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         } else {
  //           return AlertDialog(
  //             shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //             title: const Text(
  //               "Add To Cart",
  //               style: TextStyle(),
  //             ),
  //             content: const Text("Are you sure?", style: TextStyle()),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: const Text(
  //                   "Yes",
  //                   style: TextStyle(),
  //                 ),
  //                 onPressed: () async {
  //                   Navigator.of(context).pop();
  //                   _addtoCart(index);
  //                 },
  //               ),
  //               TextButton(
  //                 child: const Text(
  //                   "No",
  //                   style: TextStyle(),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         }
  //       });
  // }

  void _addtoCart(int index) {
    http.post(
        Uri.parse(
            CONSTANTS.server + "/mytutor_mp_server/mobile/php/insert_cart.php"),
        body: {
          "email": widget.reg.email.toString(),
          "subid": subjectList[index].subjectId.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.reg.cart = jsondata['data']['carttotal'].toString();
        });
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}
