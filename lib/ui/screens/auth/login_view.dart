import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_images.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body:  Center(
        child: Column(
          children: [
            Image.asset(AppImages.glogo, width: 100, height: 100),
          ],
        )
      ),
    );
  }
}
