import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constant.dart';
import '../models/reg.dart';
import 'tutor.dart';
import 'user_registration.dart';
import 'userlogin.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class MainScreen extends StatefulWidget {
  final Registration reg;
  const MainScreen({Key? key, required this.reg}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List subjectlist = [];
  String titlecenter = "Loading...";
  TextEditingController searchController = TextEditingController();
  String search = "";
  late double screenHeight, screenWidth, resWidth;
  int _selectIdx = 0;
  //final df = DateFormat('dd/MM/yyyy hh:mm a');
  var numofpage, curpage = 1;

  @override
  void initState() {
    super.initState();
    _loadProducts(1, search, "All");
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final List<Widget> _functions = <Widget>[
    Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: const SizedBox(
        child: Text(
          'Subject Provides',
          style: optionStyle,
        ),
      ),
    ),
    TutorPage(),
    const Text(
      'Index 2: School',
      style: optionStyle,
    ),
    const Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    const Text(
      'Index 4: Settings',
      style: optionStyle,
    ),
  ];

  void _onTapped(int index) {
    setState(() {
      _selectIdx = index;
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
        title: const Text('Awesome My Tutors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
        ],
      ),
      body: subjectlist.isEmpty
          ? Center(
              child: _functions.elementAt(_selectIdx),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Your Current Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                
                Expanded(
child: GestureDetector(
child: GridView.count(
crossAxisCount: 2,
children: List.generate(subjectlist.length, (index) {
return Card(
child: Column(
children: [
Flexible(flex: 6,
child: CachedNetworkImage(
width: screenWidth,
fit: BoxFit.cover,
imageUrl: CONSTANTS.server +
"/mytutor_mp_server/mobile/resources/courses/" +
subjectlist[index]['subid'] +
".png",
placeholder: (context, url) =>
const LinearProgressIndicator(),
errorWidget: (context, url, error) =>
const Icon(Icons.error),
),),),),}),
),
],
),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Subjects',
            backgroundColor: Color.fromARGB(255, 247, 143, 135),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Tutors',
            backgroundColor: Color.fromARGB(255, 129, 197, 242),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_rounded),
            label: 'Subscribe',
            backgroundColor: Color.fromARGB(255, 227, 129, 244),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
            backgroundColor: Color.fromARGB(255, 248, 135, 214),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 252, 189, 53),
          ),
        ],
        currentIndex: _selectIdx,
        selectedItemColor: Colors.black,
        onTap: _onTapped,
      ),
    );
  }

  void _loadProducts(int pageno, String _search, String _type) {
    curpage = pageno;
    numofpage ?? 1;
    //ProgressDialog pd = ProgressDialog(context: context);
    //pd.show(msg: 'Loading...', max: 100);
    http.post(
        Uri.parse(CONSTANTS.server + "/my_tutor/mobile/php/loadsubject.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
          'type': _type,
        }).then((response) {
      print(response.body);
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
