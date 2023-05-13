import 'dart:convert';

import 'package:dys_evaluation_app/fix.dart';
import 'package:dys_evaluation_app/view/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../models/reg.dart';
import 'forgetPassword.dart';
import 'mainscrn/mainscrn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth, ctrwidth;
  bool remember = false;
  bool _passwordVisible = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadPref();
  }

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
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Welcome!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: background,
                                fontSize: 30,
                                fontFamily: "roboto"),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: background,
                                fontFamily: "roboto"),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: const Text("or sign in a new account",
                                style: TextStyle(
                                    color: background,
                                    fontSize: 18,
                                    fontFamily: "roboto",
                                    fontWeight: FontWeight.bold)),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const RegisterPage()));
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'Enter your Email Address',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid email';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);

                              if (!emailValid) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                labelText: 'Enter your Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: const Text("Forgot Password",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                        fontFamily: "roboto",
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const ForgotPasswordPage()));
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: remember,
                                onChanged: (bool? value) {
                                  _onRememberMeChanged(value!);
                                },
                              ),
                              const Text("Remember Me",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            width: screenWidth,
                            height: 50,
                            child: ElevatedButton(
                              // ignore: sort_child_properties_last
                              child: const Text("Login",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: Colors.blue)))),
                              onPressed: () => {
                                //do something
                                _loginUser()
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: const Text("Skip for now",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontFamily: "roboto",
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  _emailController.text = "guest@gmail.com";
                                  _passwordController.text = "ABC123";
                                  _startwithoutlogin();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _saveRemovePref(bool value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _emailController.text;
      String password = _passwordController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value) {
        await prefs.setString('email', email);
        await prefs.setString('pass', password);
        await prefs.setBool('remember', true);
        Fluttertoast.showToast(
            msg: "Preference Stored",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      } else {
        await prefs.setString('email', '');
        await prefs.setString('pass', '');
        await prefs.setBool('remember', false);
        _emailController.text = "";
        _passwordController.text = "";
        Fluttertoast.showToast(
            msg: "Preference Removed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Preference Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      remember = false;
    }
  }

  void _onRememberMeChanged(bool value) {
    remember = value;
    setState(() {
      if (remember) {
        _saveRemovePref(true);
      } else {
        _saveRemovePref(false);
      }
    });
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    remember = (prefs.getBool('remember')) ?? false;

    if (remember) {
      setState(() {
        _emailController.text = email;
        _passwordController.text = password;
        remember = true;
      });
    }
  }

  void _loginUser() {
    String _email = _emailController.text;
    String _password = _passwordController.text;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.post(Uri.parse("${CONSTANTS.server}/dys_server/php/login.php"),
          body: {"email": _email, "password": _password}).then((response) {
        print(_email);
        print(_password);
        print(response.body);
        var logindata = json.decode(response.body);
        if (response.statusCode == 200 && logindata['status'] == 'success') {
          Registration reg = Registration.fromJson(logindata['data']);
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => MainScreen(
                        reg: reg,
                      )));
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      });
    }
  }

  void _startwithoutlogin() {
    String _email = "guest@gmail.com";
    String _password = "ABC123";
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.post(Uri.parse("${CONSTANTS.server}/dys_server/php/login.php"),
          body: {"email": _email, "password": _password}).then((response) {
        print(_email);
        print(_password);
        print(response.body);
        var logindata = jsonDecode(response.body);
        if (response.statusCode == 200 && logindata['status'] == 'success') {
          Registration reg = Registration.fromJson(logindata['data']);
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => MainScreen(
                        reg: reg,
                      )));
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      });
    }
  }
}
