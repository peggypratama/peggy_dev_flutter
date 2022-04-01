import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mobile_test/model/allListModel.dart';
import 'package:mobile_test/model/deleteListModel.dart';
import 'package:mobile_test/model/loginModel.dart';
import 'package:mobile_test/model/registerModel.dart';
import 'package:mobile_test/screen/addListPage.dart';
import 'package:mobile_test/screen/registerPage.dart';
import 'package:mobile_test/service/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  late Future<AllListModel> futureList;
  late Future<DeleteListModel> futureDeleteList;

  @override
  void initState() {
    super.initState();
    // loading = true;
    _getData();
  }

  _getData() {
    setState(() {
      futureList = Service().getAllData().catchError((err) {
        print(err);
      });
    });
  }

  _deleteList(id) {
    futureDeleteList =
        Service().deleteListData(id.toString()).catchError((err) {
      print(err);
    });

    futureDeleteList.then((value) {
      _getData();
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("object");
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddlistPage()))
              .then((value) {
            setState(() {
              _getData();
            });
          });
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder<AllListModel>(
              future: futureList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.data[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(data.name),
                                if (data.checklistCompletionStatus)
                                  Icon(Icons.check)
                              ],
                            ),
                            GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () {
                                print(data.id);
                                _deleteList(data.id);
                              },
                            ),
                            GestureDetector(
                              child: Icon(Icons.arrow_right),
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  ));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
