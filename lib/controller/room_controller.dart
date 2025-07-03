import 'package:flutter/material.dart';
import 'package:spaa/controller/consts/constants.dart';
import 'package:spaa/core/data/http/http.dart';
import 'package:spaa/core/enums/methods_enum.dart';
import 'package:spaa/model/room.dart';
import 'package:spaa/model/user.dart';

class RoomController extends ChangeNotifier {
  final HttpClient httpClient;
  RoomController(this.httpClient);

  List<Room> rooms = [];
  Room selectedRoom = Room(
    id: 0,
    name: '',
    users: [],
  );

  void updateRoom() {
    notifyListeners();
  }

  void selectRoom(Room room) {
    selectedRoom = room;
    notifyListeners();
  }

  Future<List<Room>> getRooms() async {
    try {
      final response = await httpClient.request(
          url:
              // 'https://rfidbackend-production-d880.up.railway.app/api/room'

              '${AppConstants.appUrl}/room',
          method: MethodEnum.get);
      final List<Room> roomList = List.from(
        response['rooms'].map(
          (room) {
            return Room.fromMap(room);
          },
        ),
      );
      rooms = roomList;
      notifyListeners();
      return roomList;
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

  Future<void> addUser(int roomId, User user) async {
    try {
      var request = await httpClient.request(
          url: '${AppConstants.appUrl}/Room/$roomId/addUser/${user.accessId}',
          method: MethodEnum.post);
      if (request.isNotEmpty) {
        selectedRoom.users.add(user);
      }
      notifyListeners();
    } on HttpError {
      rethrow;
    }
  }

  Future<void> removeUser(int roomId, String userAccessId) async {
    try {
      var request = await httpClient.request(
          url: '${AppConstants.appUrl}/room/$roomId/removeUser/$userAccessId',
          method: MethodEnum.delete);
      if (request.isNotEmpty) {
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
