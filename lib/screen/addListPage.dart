import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mobile_test/data/global-vars.dart';
import 'package:mobile_test/model/addListModel.dart';
import 'package:mobile_test/model/loginModel.dart';
import 'package:mobile_test/model/registerModel.dart';
import 'package:mobile_test/screen/homePage.dart';
import 'package:mobile_test/screen/registerPage.dart';
import 'package:mobile_test/service/service.dart';

class AddlistPage extends StatefulWidget {
  const AddlistPage({Key? key}) : super(key: key);

  @override
  State<AddlistPage> createState() => _AddlistPageState();
}

class _AddlistPageState extends State<AddlistPage> {
  TextEditingController cUsername = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  late Future<AddListModel> futureaddList;

  Addlist() {
    futureaddList = Service().postList(cUsername.text).catchError((err) {
      print(err);
    });

    futureaddList.then((value) {
      print("ok");
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add List")),
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
                            decoration: InputDecoration(labelText: "Nama"),
                          ),
                        ),
                      ],
                    ))),
            Container(
              child: ElevatedButton(
                  child: Text("Add List"),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      Addlist();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
