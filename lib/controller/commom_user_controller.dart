import 'package:flutter/material.dart';
import 'package:spaa/core/data/http/http.dart';
import 'package:spaa/model/common_user.dart';

class CommomUserController extends ChangeNotifier {
  final HttpClient httpClient;
  CommomUserController(this.httpClient);

  List<CommonUser> users = [];

  void getUsers() async {}
  void deleteUser() async {}
  void editUser() async {}
}
