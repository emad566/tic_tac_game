import 'package:flutter/material.dart';
import 'package:tic_tac_game/moduls/home_screen.dart';
import 'package:tic_tac_game/shared/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.light,
      home: const HomeScreen(),
    );
  }
}
