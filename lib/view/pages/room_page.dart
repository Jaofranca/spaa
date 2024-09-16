import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:spaa/controller/room_controller.dart';
import 'package:spaa/controller/user_controller.dart';
import 'package:spaa/core/infra/http/http_adapter.dart';

import 'package:spaa/core/styles/app_fonts.dart';
import 'package:spaa/view/pages/add_user_page.dart';
import 'package:spaa/view/widgets/modal_bottom_custom.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final roomController = context.read<RoomController>();
      await roomController.getRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomController>(builder: (context, roomController, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddUserPage(),
                      ),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.add))
            ],
            centerTitle: true,
            title: Text(
              "Usuários",
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
                        for (var i in roomController.selectedRoom.users)
                          DataRow(cells: [
                            DataCell(
                              Text(i.name,
                                  style: Theme.of(context).textTheme.smallText),
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ModalBottomCustom(
                                      onRemove: () async {
                                        await roomController.removeUser(
                                            context
                                                .read<RoomController>()
                                                .selectedRoom
                                                .id,
                                            i.accessId);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                              // showEditIcon: true
                            ),
                            DataCell(
                                Text(
                                  i.identification,
                                  style: Theme.of(context)
                                      .textTheme
                                      .smallText
                                      .copyWith(fontSize: 12),
                                ), onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return ModalBottomCustom(
                                    onRemove: () async {
                                      await roomController.removeUser(
                                          context
                                              .read<RoomController>()
                                              .selectedRoom
                                              .id,
                                          i.accessId);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            }),
                          ], onLongPress: () {})
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
  }
}



// Table(
//                         border: TableBorder.symmetric(
//                             inside:
//                                 const BorderSide(width: 1, color: Colors.blue),
//                             outside: const BorderSide(width: 1)),
//                         // defaultColumnWidth: const FixedColumnWidth(double.infinity),
//                         columnWidths: {
//                           0: FixedColumnWidth(constraints.maxWidth * 0.3),
//                           1: FixedColumnWidth(constraints.maxWidth * 0.6)
//                         },
//                         children: [
//                           const TableRow(
//                             decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 182, 175, 175)),
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text("matricula"),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text("aluno"),
//                               ),
//                             ],
//                           ),
//                           // for (var i in users)
//                           for (var i in list)
//                             TableRow(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     // i.id,
//                                     "test",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .smallText
//                                         .copyWith(fontSize: 12),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     // i.name,
//                                     "joao",
//                                     style:
//                                         Theme.of(context).textTheme.smallText,
//                                   ),
//                                 ),
//                               ],
//                             )
//                         ]),