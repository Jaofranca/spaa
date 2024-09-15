import 'package:flutter/material.dart';
import 'package:spaa/controller/consts/constants.dart';
import 'package:spaa/core/data/http/http.dart';
import 'package:spaa/core/enums/methods_enum.dart';
import 'package:spaa/model/room.dart';

class RoomController extends ChangeNotifier {
  final HttpClient httpClient;
  RoomController(this.httpClient);

  List<Room> rooms = [];
  Room selectedRoom = Room(
    id: 0,
    name: '',
    users: [],
  );

  void selectRoom(Room room) {
    selectedRoom = room;
    notifyListeners();
  }

  Future<List<Room>> getRooms() async {
    try {
      final response = await httpClient.request(
          url: '${AppConstants.appUrl}/room', method: MethodEnum.get);
      final List<Room> RoomList = List.from(
        response['rooms'].map(
          (room) {
            return Room.fromMap(room);
          },
        ),
      );
      rooms = RoomList;
      notifyListeners();
      return RoomList;
    } on HttpError {
      rethrow;
    }
  }

  Future<Room> getRoomById(int id) async {
    try {
      final response = await httpClient.request(
          url: '${AppConstants.appUrl}/room/$id', method: MethodEnum.get);

      final room = Room.fromMap(response);
      notifyListeners();
      return room;
    } on HttpError {
      rethrow;
    }
  }

  Future<void> removeUser(String roomId, String userAccessId) async {
    try {
      var request = await httpClient.request(
          url: '${AppConstants.appUrl}/Room/$roomId/removeUser/$userAccessId',
          method: MethodEnum.delete);
      if (request.isNotEmpty) {
        var selectedRoom = rooms.firstWhere((element) => element.id == roomId);
        selectedRoom.users
            .removeWhere((element) => element.accessId == userAccessId);
      }
      notifyListeners();
    } on HttpError {
      rethrow;
    }
  }

// {roomId}/removeUser/{userAccessId}
  void editUser() {}

  void createUser() {}

  // void editUser(Room oldUser,Room user){

  // }
}
