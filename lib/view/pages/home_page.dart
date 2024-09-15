import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:spaa/controller/room_controller.dart';
import 'package:spaa/controller/user_controller.dart';
import 'package:spaa/core/infra/http/http_adapter.dart';
import 'package:spaa/view/widgets/room_card.dart';
import 'package:spaa/core/styles/app_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpAdapter http = HttpAdapter(Client());
  late UserController userController;
  late RoomController roomController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userController = Provider.of<UserController>(context);
    roomController = Provider.of<RoomController>(context);
    roomController.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: const [
              ListTile(
                title: Text('Perfil'),
              ),
              ListTile(
                title: Text('Configurações'),
              ),
              ListTile(
                title: Text('School'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              ),
            )
          ],
          centerTitle: true,
          title: Text("Salas",
              style: Theme.of(context)
                  .textTheme
                  .bigText
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        body: SizedBox(
            child: Column(children: [
          Text(
            "Escolha sua Sala",
            style: Theme.of(context).textTheme.mediumText,
          ),
          for (var i in roomController.rooms)
            RoomCard(
              title: i.name,
              onTap: () {
                roomController.selectRoom(i);
              },
            ),
        ])),
      ),
    );
  }
}
