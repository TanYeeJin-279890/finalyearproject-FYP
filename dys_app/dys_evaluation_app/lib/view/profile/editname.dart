// This class handles the Page to edit the Name Section of the User Profile.
import 'dart:convert';
import 'package:dys_evaluation_app/models/reg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constant.dart';
import '../../widgets/appbar_widget.dart';
import 'package:http/http.dart' as http;

class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key, required this.reg}) : super(key: key);
  final Registration reg;
  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void updateUserValue(String name) {
    String newname = name;
    http.post(Uri.parse("${CONSTANTS.server}/dys_server/php/updateName.php"),
        body: {
          "name": newname,
          "id": widget.reg.id.toString(),
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Update success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        print("Update success");
        setState(() {
          widget.reg.name = newname;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Update Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        print("Update Failed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                  width: 330,
                  child: Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 310,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  (value.length < 3)) {
                                return 'Name must be longer than 3 value';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            controller: firstNameController,
                          ))),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              updateUserValue(firstNameController.text);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}
