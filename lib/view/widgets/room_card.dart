import 'package:flutter/material.dart';
import 'package:spaa/core/styles/app_colors.dart';
import 'package:spaa/core/styles/app_fonts.dart';
import 'package:spaa/view/pages/room_page.dart';

class RoomCard extends StatelessWidget {
  final String title;
  const RoomCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: kcardColor,
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RoomPage(),
              ),
            );
          },
          title: Text(
            title,
            style: Theme.of(context).textTheme.mediumText,
          ),
          subtitle: const Text("Laboratório 2"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Acesse a sala",
                style: Theme.of(context)
                    .textTheme
                    .smallText
                    .copyWith(fontSize: 12),
              ),
              const Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
