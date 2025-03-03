import 'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/auth/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Login()
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}