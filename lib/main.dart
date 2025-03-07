import 'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/auth/signupform_view.dart';
import 'package:provider/provider.dart';
import 'package:novel_truck/ui/screens/auth/signupform_viewmodel.dart';
import 'package:novel_truck/ui/screens/home/home_view.dart';
import 'package:novel_truck/ui/screens/auth/login_view.dart';
import 'package:novel_truck/ui/screens/home/homenav_view.dart';
void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_)=>SignUpFormViewModel())
  ],
    child:MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      home: HomeNav(),
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}