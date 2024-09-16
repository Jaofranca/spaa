import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaa/controller/room_controller.dart';
import 'package:spaa/controller/user_controller.dart';
import 'package:spaa/core/styles/app_fonts.dart';
import 'package:spaa/model/user.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  bool _isLoading = true;
  List<bool> selectedIndex = [];
  List<User?> _selectedRows = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers here
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userController = context.read<UserController>();
      await userController
          .getUsersWithoutRoom(context.read<RoomController>().selectedRoom);
      selectedIndex =
          List.filled(userController.unsellectedUsers.length, false);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Consumer<RoomController>(builder: (context, roomController, child) {
      return Consumer<UserController>(
          builder: (context, userController, child) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: IconButton(
              onPressed: () async {
                for (var i in _selectedRows) {
                  await roomController.addUser(
                      roomController.selectedRoom.id, i!);
                }
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
                size: 40,
              ),
              color: Colors.blueAccent,
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Adicione Usuários",
                style: Theme.of(context)
                    .textTheme
                    .bigText
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataTable(columns: [
                          DataColumn(
                            label: Text(
                              "Nome",
                              style: Theme.of(context).textTheme.smallText,
                            ),
                          ),
                          DataColumn(
                              label: Text(
                            "Identificador",
                            style: Theme.of(context).textTheme.smallText,
                          )),
                        ], rows: [
                          for (int i = 0;
                              i < userController.unsellectedUsers.length;
                              i++) ...[
                            DataRow(
                                selected: selectedIndex[i],
                                onSelectChanged: (bool? selected) {
                                  setState(() {
                                    selectedIndex[i] = selected ?? false;
                                    selected == true
                                        ? _selectedRows.add(User(
                                            name: userController
                                                .unsellectedUsers[i].name,
                                            accessId: userController
                                                .unsellectedUsers[i].accessId,
                                            identification: userController
                                                .unsellectedUsers[i]
                                                .identification))
                                        : _selectedRows.removeWhere(
                                            (item) =>
                                                item!.accessId ==
                                                userController
                                                    .unsellectedUsers[i]
                                                    .accessId,
                                          );
                                  });
                                },
                                cells: [
                                  DataCell(
                                    Text(
                                        userController.unsellectedUsers[i].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .smallText),
                                  ),
                                  DataCell(
                                    Text(
                                      userController
                                          .unsellectedUsers[i].identification,
                                      style: Theme.of(context)
                                          .textTheme
                                          .smallText
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                                onLongPress: () {})
                          ]
                        ])
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      });
    });
  }
}
