import 'package:flutter/material.dart';
import 'package:spaa/controller/consts/constants.dart';
import 'package:spaa/core/data/http/http.dart';
import 'package:spaa/core/enums/methods_enum.dart';
import 'package:spaa/model/room.dart';
import 'package:spaa/model/user.dart';

class UserController extends ChangeNotifier {
  final HttpClient httpClient;
  UserController(this.httpClient);

  List<User> users = [];
  List<User> unsellectedUsers = [];

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

  Future<List<User>> getUsersWithoutRoom(Room room) async {
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

      var onlyInList1 = usersList
          .where((user) => !room.users.any(
                (roomUser) => roomUser.accessId == user.accessId,
              ))
          .toList();

      unsellectedUsers = onlyInList1;

      notifyListeners();
      return unsellectedUsers;
    } on HttpError {
      rethrow;
    }
  }

  void setUnsellectedUsers(List<User> users) {
    unsellectedUsers = users;
  }

  void deleteUser() async {}
  void editUser() async {}
}
