import 'package:flutter/material.dart';
import 'package:gamebuddy/pages/games_list.dart';
import 'package:gamebuddy/pages/login_page.dart';
import 'package:gamebuddy/pages/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Change this to your desired initial route
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/gameList': (context) => const GameListScreen(),
      },
    );
  }
}
