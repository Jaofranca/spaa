import 'package:flutter/material.dart';
import 'package:spaa/controller/consts/constants.dart';
import 'package:spaa/core/data/http/http.dart';
import 'package:spaa/core/enums/methods_enum.dart';
import 'package:spaa/model/user.dart';

class UserController extends ChangeNotifier {
  final HttpClient httpClient;
  UserController(this.httpClient);

  List<User> users = [];

  Future<List<User>> getUsers() async {
    try {
      final response = await httpClient.request(
          url: '${AppConstants.appUrl}/user', method: MethodEnum.get);
      final List<User> usersList = List.from(
        response['users'].map(
          (userMap) {
            return User.fromMap(userMap);
          },
        ),
      );
      users = usersList;
      notifyListeners();
      return usersList;
    } on HttpError {
      rethrow;
    }
  }

  void deleteUser() async {}
  void editUser() async {}
}
