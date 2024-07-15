import 'package:flutter/material.dart';
import 'package:spaa/core/data/http/http_client.dart';
import 'package:spaa/model/authorized_user.dart';

class AuthorizedUserController extends ChangeNotifier {
  final HttpClient httpClient;
  AuthorizedUserController(this.httpClient);

  List<AuthorizedUser> users = [];

  void getUsers() async {
    // try {
    //   final response = await httpClient.request(
    //       url: AppConstants.appUrl, method: MethodEnum.get);

    //   final List<AuthorizedUser> usersList = List.from(
    //     // response.map(
    //     //   (people) {
    //     //     return usermaper.fromMap(people);
    //     //   },
    //     // ),
    //   );

    //   return usersList;
    notifyListeners();
    // } on HttpError {
    //   rethrow;
    // }
  }

  void removeUser(AuthorizedUser user) {
    users.remove(user);
    notifyListeners();
  }

  void editUser() {}

  // void editUser(AuthorizedUser oldUser,AuthorizedUser user){

  // }
}
