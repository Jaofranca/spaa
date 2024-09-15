import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:spaa/controller/room_controller.dart';
import 'package:spaa/controller/user_controller.dart';
import 'package:spaa/core/infra/http/http_adapter.dart';

import 'package:spaa/view/pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => HttpAdapter(Client())),
        ChangeNotifierProvider(
            create: (_) => UserController(_.read<HttpAdapter>())),
        ChangeNotifierProvider(
            create: (_) => RoomController(_.read<HttpAdapter>())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
