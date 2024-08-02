import 'package:flutter/material.dart';
import 'package:spaa/core/styles/app_colors.dart';
import 'package:spaa/core/styles/app_fonts.dart';
import 'package:spaa/model/authorized_user.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<AuthorizedUser> users = [
      AuthorizedUser(
          id: "20191045050162", name: "Joao carlos montes", accessId: "11111"),
      AuthorizedUser(
          id: "20191045050162", name: "Marcos gael silva", accessId: "11111"),
      AuthorizedUser(
          id: "20191045050162", name: "Gael juliano almeida", accessId: "11111")
    ];
    return SafeArea(
      child: Scaffold(
        bottomSheet:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(onPressed: () {}, child: Text("Adicionar alunos")),
          TextButton(onPressed: () {}, child: Text("Editar Sala")),
        ]),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Alunos",
            style: Theme.of(context)
                .textTheme
                .bigText
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Table(
                      border: TableBorder.symmetric(
                          inside:
                              const BorderSide(width: 1, color: Colors.blue),
                          outside: const BorderSide(width: 1)),
                      // defaultColumnWidth: const FixedColumnWidth(double.infinity),
                      columnWidths: {
                        0: FixedColumnWidth(constraints.maxWidth * 0.3),
                        1: FixedColumnWidth(constraints.maxWidth * 0.6)
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 182, 175, 175)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("matricula"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("aluno"),
                            ),
                          ],
                        ),
                        for (var i in users)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  i.id,
                                  style: Theme.of(context)
                                      .textTheme
                                      .smallText
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  i.name,
                                  style: Theme.of(context).textTheme.smallText,
                                ),
                              ),
                            ],
                          )
                      ]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
