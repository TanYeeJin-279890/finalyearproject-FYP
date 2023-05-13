import 'dart:async';

import 'package:dys_evaluation_app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyslexia Strength Evaluation Application',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(title: 'Welcome to Dys Strength Evaluate App'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
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
            colors: [
              Color.fromRGBO(3, 24, 255, 1),
              Color.fromRGBO(3, 129, 255, 1),
              Color.fromRGBO(45, 171, 255, 1),
              Color.fromRGBO(189, 245, 255, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                //backgroundcolor: Colors.amber,
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3997/3997864.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome to Dyslexia Strength Evaluation App!',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "roboto",
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
              ),
              const SizedBox(height: 50),
              const SizedBox(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
