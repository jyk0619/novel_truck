import 'package:flutter/material.dart';

class Home extends StatelessWidget {
   Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(child: Text('Home')),);
  }
}
