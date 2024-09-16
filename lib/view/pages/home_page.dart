import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaa/controller/room_controller.dart';
import 'package:spaa/controller/user_controller.dart';
import 'package:spaa/view/pages/room_page.dart';
import 'package:spaa/view/widgets/room_card.dart';
import 'package:spaa/core/styles/app_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RoomController roomController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      roomController = context.read<RoomController>();
      await roomController.getRooms();
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
          actions: const [],
          centerTitle: true,
          title: Text("Salas",
              style: Theme.of(context)
                  .textTheme
                  .bigText
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        body: SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(
                "Escolha sua Sala",
                style: Theme.of(context).textTheme.mediumText,
              ),
              for (var i in context.read<RoomController>().rooms)
                RoomCard(
                  title: i.name,
                  onTap: () {
                    context.read<RoomController>().selectRoom(i);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomPage(),
                      ),
                    );
                  },
                ),
            ])),
      ),
    );
  }
}
