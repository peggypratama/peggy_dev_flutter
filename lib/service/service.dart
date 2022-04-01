import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_test/data/constant.dart';
import 'package:mobile_test/data/global-vars.dart';
import 'package:mobile_test/model/addListModel.dart';
import 'package:mobile_test/model/allListModel.dart';
import 'package:mobile_test/model/deleteListModel.dart';
import 'package:mobile_test/model/loginModel.dart';
import 'package:mobile_test/model/registerModel.dart';

class Service {
  Future<LoginModel> createLogin(String username, String password) async {
    final response = await http.post(
      Uri.parse(Constant.URL + "login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
        'username': username,
      }),
    );
    print(username);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal Upload Data');
    }
  }

  Future<RegisterModel> createRegister(
      String email, String username, String password) async {
    final response = await http.post(
      Uri.parse(Constant.URL + "register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal Upload Data');
    }
  }

  Future<AllListModel> getAllData() async {
    final response = await http.get(
      Uri.parse(Constant.URL + "checklist"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + GlobalVars.TOKEN
      },
    );
    if (response.statusCode == 200) {
      return AllListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal Download Data');
    }
  }

  Future<AddListModel> postList(String name) async {
    final response = await http.post(
      Uri.parse(Constant.URL + "checklist"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + GlobalVars.TOKEN
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return AddListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal Upload Data');
    }
  }

  Future<DeleteListModel> deleteListData(String id) async {
    final response = await http.delete(
      Uri.parse(Constant.URL + "checklist/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + GlobalVars.TOKEN
      },
    );
    if (response.statusCode == 200) {
      return DeleteListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal Download Data');
    }
  }
}
