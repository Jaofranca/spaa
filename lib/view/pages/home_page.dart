import 'package:flutter/material.dart';
import 'package:spaa/view/widgets/room_card.dart';
import 'package:spaa/core/styles/app_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Drawer(),
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
          const RoomCard(
            title: 'Sala 1',
          ),
        ])),
      ),
    );
  }
}
