import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaa/controller/user_controller.dart';
import 'package:spaa/model/user.dart';

class EditUserPage extends StatefulWidget {
  final User user;
  const EditUserPage({super.key, required this.user});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late UserController userController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userController = Provider.of<UserController>(context);
    userController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("teste")),
      body: Column(
        children: [
          const TextField(),
          const TextField(),
          ElevatedButton(
            onPressed: () {},
            child: const Text("data"),
          )
        ],
      ),
    );
  }
}
