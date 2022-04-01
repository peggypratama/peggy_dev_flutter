import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mobile_test/data/global-vars.dart';
import 'package:mobile_test/model/loginModel.dart';
import 'package:mobile_test/model/registerModel.dart';
import 'package:mobile_test/screen/homePage.dart';
import 'package:mobile_test/screen/registerPage.dart';
import 'package:mobile_test/service/service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  late Future<LoginModel> futureLogin;

  _login() {
    futureLogin = Service().createLogin(cUsername.text, cPassword.text);

    futureLogin.then((value) {
      // Fluttertoast.showToast(msg: "msg");
      setState(() {
        GlobalVars.TOKEN = value.data.token;
      });
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
                  child: Text("Login"),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _login();
                    }
                  }),
            ),
            Container(
              child: ElevatedButton(
                  child: Text("Register"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegisterPage()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
