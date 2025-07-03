import 'package:flutter/material.dart';
import 'package:spaa/core/styles/app_colors.dart';
import 'package:spaa/core/styles/app_fonts.dart';

class RoomCard extends StatelessWidget {
  final String title;
  final String usersCount;
  final void Function() onTap;
  const RoomCard(
      {super.key,
      required this.title,
      required this.onTap,
      required this.usersCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: kcardColor,
        child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: Theme.of(context).textTheme.mediumText,
          ),
          subtitle: Text("Quantidade de usuários: " '$usersCount'),
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
