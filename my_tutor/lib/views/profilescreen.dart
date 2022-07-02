import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart'
    show AndroidUiSettings, CropAspectRatioPreset, IOSUiSettings, ImageCropper;
import 'package:image_picker/image_picker.dart';
import '../constant.dart';
import 'userlogin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String pathAsset = 'assets/images/camera.png';
  var _image;
  bool _passwordVisible = true;
  late double screenHeight,
      screenWidth,
      resWidth; //used to get the device width and height and set up a responsive widget.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
            //padding: const EdgeInsets.all(10),
            child: Center(
                child: SizedBox(
      width: resWidth,
      child: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(height: 50),
          const Text('Welcome',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 48,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
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
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _nameController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Enter your Name',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty || (value.length < 3)) {
                  return 'Name must be longer than 3';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _emailController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Enter your Email',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill in the email';
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Enter your Phone',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Enter your Home Address',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Home Address';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: _passwordVisible,
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Enter your password',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid password';
                }
                //add validator for the password pattern
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              obscureText: _passwordVisible,
              textInputAction: TextInputAction.next,
              controller: _repasswordController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Please re-enter your password',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              validator: (value) {
                String password = _passwordController.text;
                if (value == null || value.isEmpty) {
                  return 'Please re-enter your password';
                }
                if (value != password) {
                  return "Re-entered password not match.";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              child: const Text("Register"),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.red)))),
              onPressed: _regDialog,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text("Done Registered? Click Me!",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()));
            },
          ),
        ]),
      ),
    ))));
  }

  _takePictureDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select From"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _galleryPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ),
          );
        });
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _regDialog() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Register as new user?",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _registerUser();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _registerUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    String _name = _nameController.text;
    String _email = _emailController.text;
    String _phone = _phoneController.text;
    String _address = _addressController.text;
    String _password = _passwordController.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());

    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor_mp/mobile/php/registration.php"),
        body: {
          "name": _name,
          "email": _email,
          "phone": _phone,
          "address": _address,
          "password": _password,
          "image": base64Image,
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Registration Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        return;
      } else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        return;
      }
    });
  }
}
