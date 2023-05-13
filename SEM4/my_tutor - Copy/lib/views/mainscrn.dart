import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_tutor/views/user_registration.dart';
import 'package:my_tutor/views/userlogin.dart';

import '../constant.dart';
import '../models/reg.dart';
import '../models/courses.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainScrn extends StatefulWidget {
  final Registration reg;
  const MainScrn({
    Key? key,
    required this.reg,
  }) : super(key: key);

  @override
  State<MainScrn> createState() => _MainScrnState();
}

class _MainScrnState extends State<MainScrn> {
  List<Course> courseList = <Course>[];
  String titlecenter = "Loading...";
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  var numofpage, curpage = 1;
  //int numofitem = 0;
  var color;
  int cart = 0;
  TextEditingController searchController = TextEditingController();
  String search = "";
  String dropdownvalue = 'Beverage';
  var types = [
    'All',
    'Baby',
    'Beverage',
    'Bread',
    'Breakfast',
    'Canned Food',
    'Condiment',
    'Care Product',
    'Dairy',
    'Dried Food',
    'Grains',
    'Frozen',
    'Snack',
    'Health',
    'Meat',
    'Miscellaneous',
    'Seafood',
    'Pet',
    'Produce',
    'Household',
    'Vegetables',
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts(1, search, "All");
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
        title: const Text('Products'),
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
                _loadProducts(1, search, "All");
              }
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.reg.name.toString()),
              accountEmail: Text(widget.reg.email.toString()),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.myanimelist.net/r/360x360/images/characters/9/310307.jpg?s=56335bffa6f5da78c3824ba0dae14a26"),
              ),
            ),
            _createDrawerItem(
              icon: Icons.tv,
              text: 'Products',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScrn(
                              reg: widget.reg,
                            )));
              },
            ),
            _createDrawerItem(
              icon: Icons.local_shipping_outlined,
              text: 'My Cart',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.supervised_user_circle,
              text: 'My Orders',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.verified_user,
              text: 'My Profile',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: courseList.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  Center(
                      child: Text(titlecenter,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: types.map((String char) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: ElevatedButton(
                            child: Text(char),
                            onPressed: () {
                              _loadProducts(1, "", char);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: types.map((String char) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: ElevatedButton(
                        child: Text(char),
                        onPressed: () {
                          _loadProducts(1, "", char);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(courseList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadProductDetails(index)},
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/slumshop/assets/products/" +
                                      courseList[index].courseId.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Text(
                                courseList[index].productName.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Column(children: [
                                              Text("RM " +
                                                  double.parse(courseList[index]
                                                          .productPrice
                                                          .toString())
                                                      .toStringAsFixed(2)),
                                              Text(courseList[index]
                                                      .productQty
                                                      .toString() +
                                                  " units"),
                                            ]),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.shopping_cart))),
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
                          onPressed: () =>
                              {_loadProducts(index + 1, "", "All")},
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

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _loadProducts(int pageno, String _search, String _type) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/slumshop/mobile/php/load_products.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
          'type': _type,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);
        if (extractdata['products'] != null) {
          courseList = <Course>[];
          extractdata['products'].forEach((v) {
            courseList.add(Course.fromJson(v));
          });
          titlecenter = courseList.length.toString() + " Products Available";
        } else {
          titlecenter = "No Product Available";
          courseList.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Product Available";
        courseList.clear();
        setState(() {});
      }
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

  _loadProductDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Product Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/slumshop/assets/products/" +
                      courseList[index].productId.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  courseList[index].productName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Product Description: \n" +
                      courseList[index].productDesc.toString()),
                  Text("Price: RM " +
                      double.parse(courseList[index].productPrice.toString())
                          .toStringAsFixed(2)),
                  Text("Quantity Available: " +
                      courseList[index].productQty.toString() +
                      " units"),
                  Text("Product Status: " +
                      courseList[index].productStatus.toString()),
                  Text("Product Date: " +
                      df.format(DateTime.parse(
                          courseList[index].productDate.toString()))),
                ]),
              ],
            )),
            actions: [
              SizedBox(
                  width: screenWidth / 1,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Add to cart"))),
            ],
          );
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
                  "Search ",
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
                      const SizedBox(height: 5),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0))),
                        child: DropdownButton(
                          value: dropdownvalue,
                          underline: const SizedBox(),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: types.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchController.text;
                      Navigator.of(context).pop();
                      _loadProducts(1, search, "All");
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

  void _onLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const LoginPage()));
  }

  void _onRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const RegisterPage()));
  }
}
