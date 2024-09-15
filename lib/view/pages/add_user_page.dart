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
  late UserController userController;
  late RoomController roomController;
  bool _isLoading = true;
  List<bool> selectedIndex = [];
  List<User?> _selectedRows = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers here
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      roomController = context.read<RoomController>();
      userController = context.read<UserController>();
      await userController.getUsers();
      selectedIndex = List.filled(userController.users.length, false);
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

    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.check,
            size: 40,
          ),
          color: Colors.blueAccent,
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
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
                          i < context.read<UserController>().users.length;
                          i++) ...[
                        DataRow(
                            // selected: selectedIndex[i],
                            onSelectChanged: (bool? selected) {
                              setState(() {
                                selectedIndex[i] = selected ?? false;
                                selected == true
                                    ? _selectedRows.add(User(
                                        name: userController.users[i].name,
                                        accessId:
                                            userController.users[i].accessId,
                                        identification: userController
                                            .users[i].identification))
                                    : _selectedRows.removeWhere(
                                        (item) =>
                                            item!.accessId ==
                                            userController.users[i].accessId,
                                      );
                              });
                            },
                            cells: [
                              DataCell(
                                Text(userController.users[i].name,
                                    style:
                                        Theme.of(context).textTheme.smallText),
                              ),
                              DataCell(
                                Text(
                                  userController.users[i].identification,
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
  }
}
