// This class handles the Page to edit the Phone Section of the User Profile.
import 'dart:convert';
import 'package:dys_evaluation_app/models/reg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constant.dart';
import '../../widgets/appbar_widget.dart';
import 'package:http/http.dart' as http;

class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key, required this.reg}) : super(key: key);
  final Registration reg;
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void updateUserValue(String phone) {
    String newphone = phone;
    http.post(Uri.parse("${CONSTANTS.server}/dys_server/php/updatePhone.php"),
        body: {
          "phone": newphone,
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
          widget.reg.phone = newphone;
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
                    "What's Your Phone Number?",
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
                            // Handles Form Validation for First Phone
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Your Phone Number'),
                            controller: phoneController,
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
                              updateUserValue(phoneController.text);
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
