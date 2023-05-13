import 'package:flutter/material.dart';
import '../fix.dart';
import '../views/ques.dart';
import 'login.dart';
import 'register.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late double screenHeight, screenWidth, ctrwidth;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   loadPref();
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth;
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: ctrwidth,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Before we start, please enter the evaluatee's information.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: 'Enter the Evaluatee Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid name';
                            }
                            bool nameValid =
                                RegExp(r"^[A-Za-z\s]*$").hasMatch(value);

                            if (!nameValid) {
                              return 'Please enter a valid name';
                            }
                            if (value.length < 3) {
                              return 'Please enter a valid name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                              labelText: 'Enter the Evaluatee Age',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid age';
                            }
                            // bool ageValid = RegExp(
                            //         r"^(0?[1-9]|[1-9][0-9]s|[1][1-9][1-9]|100)$")
                            //     .hasMatch(value);

                            // if (!ageValid) {
                            //   return 'Please enter a valid age';
                            // }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: screenWidth,
                          height: 50,
                          child: ElevatedButton(
                            // ignore: sort_child_properties_last
                            child: const Text("Start",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            color: Colors.blue)))),
                            //to questionnaire page
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const QuesScreen()));
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: const Text("Wanna Login? Click Me!",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage()));
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          child: const Text("Not Yet Registered? Click Me!",
                              style: TextStyle(
                                  color: submitbtn,
                                  fontSize: 15,
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const RegisterPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
