import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double screenHeight, screenWidth, resWidth;
  final _formKey = GlobalKey<FormState>();
  String pathAsset = 'assets/images/camera.png';
  var _image;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: resWidth,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text('Welcome'),
                  Card(
                    child: GestureDetector(
                        onTap: () => {_takePictureDialog()},
                        child: SizedBox(
                            height: screenHeight / 3,
                            width: screenWidth,
                            child: _image == null
                                ? Image.asset(pathAsset)
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _takePictureDialog() {}
}
