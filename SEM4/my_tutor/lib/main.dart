import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_tutor/views/userlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_tutor/constant.dart';
import 'models/reg.dart';
import 'views/mainscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tutor App',
      theme: ThemeData(
        //scaffoldBackgroundColor: Color.fromARGB(255, 210, 53, 6),
        primarySwatch: Colors.red,
      ),
      home: const MySplashScreen(title: 'Welcome to My Tutor App'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool remember = false;
  String status = "Loading...";

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.orange, Colors.yellowAccent],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  //backgroundcolor: Colors.amber,
                  child: Image.asset(
                    'assets/images/tutor.png',
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  )),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome to My Tutor App!',
                    textAlign: TextAlign.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    textStyle: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: ("Monospace"),
                      color: Colors.black,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 20,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              const SizedBox(height: 50),
              const SizedBox(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    remember = (prefs.getBool('remember')) ?? false;

    if (remember) {
      setState(() {
        status = "Credentials found, auto log in...";
      });
      _loginUser(email, password);
    } else {
      _loginUser(email, password);
      setState(() {
        status = "Login as guest...";
      });
    }
  }

  _loginUser(email, password) {
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor_mp_server/mobile/php/login.php"),
        body: {"email": email, "password": password}).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        var extractdata = data['data'];
        Registration reg = Registration.fromJson(extractdata);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => MainScreen(
                      reg: reg,
                    )));
      } else {
        Registration reg = Registration(
            id: '0',
            name: 'guest',
            email: 'guest@slumberjer.com',
            datereg: '0',
            cart: '0');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => MainScreen(
                      reg: reg,
                    )));
      }
    });
  }
}
