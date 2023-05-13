import 'dart:async';
import 'package:flutter/material.dart';
import 'bmicalc.dart';

void main() {
  //main method = starting / entry point for every flutter application to start running
  runApp(const MyApp()); // initiate user interface
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // constructor

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch:
                Colors.yellow //primary colour of the theme in the application
            ),
        home: const SplashScrn());
  }
}

class SplashScrn extends StatefulWidget {
  //main class
  const SplashScrn({Key? key}) : super(key: key);

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

class _SplashScrnState extends State<SplashScrn> {
  //state class
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    // => is goto
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const BMIScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "BMI CALC",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              )
            ]),
      ),
    );
  }
}
