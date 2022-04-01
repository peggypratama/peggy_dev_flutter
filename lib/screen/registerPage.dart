import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_test/model/registerModel.dart';
import 'package:mobile_test/service/service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  late Future<RegisterModel> futureRegister;

  _register() {
    futureRegister =
        Service().createRegister(cEmail.text, cUsername.text, cPassword.text);
    // print(futureRegister.then((value) => print(value.data.alamat)));
    // });
    futureRegister.then((value) {
      // Fluttertoast.showToast(msg: "Berhasil register");
      Navigator.of(context).pop();
    }).catchError((error) {
      // Fluttertoast.showToast(msg: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                child: Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: cEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field Tidak Boleh Kosong";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: cUsername,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field Tidak Boleh Kosong";
                              }
                            },
                            decoration: InputDecoration(labelText: "Username"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: cPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field Tidak Boleh Kosong";
                              }
                            },
                            decoration: InputDecoration(labelText: "Password"),
                          ),
                        )
                      ],
                    ))),
            Container(
              child: ElevatedButton(
                  child: Text("Register"),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _register();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
