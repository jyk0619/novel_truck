import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/screens/auth/ezsignup_view.dart';
import 'package:novel_truck/ui/screens/auth/login_viewmodel.dart';
import 'package:novel_truck/ui/screens/auth/signupform_view.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/record/record_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:novel_truck/ui/screens/auth/signupform_viewmodel.dart';
import 'package:novel_truck/ui/screens/home/home_view.dart';
import 'package:novel_truck/ui/screens/auth/login_view.dart';
import 'package:novel_truck/ui/screens/auth/login_viewmodel.dart';
import 'package:novel_truck/ui/screens/home/homenav_view.dart';
import'package:novel_truck/core/theme/app_theme.dart';
import 'package:novel_truck/ui/screens/auth/signupcom_view.dart';
import 'package:novel_truck/ui/screens/novel/collection_view.dart';
import 'package:novel_truck/ui/screens/novel/collectionadd_view.dart';
import 'package:novel_truck/ui/screens/auth/agree_view.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import  'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName:"assets/config/.env");
  String? kakaoNativeAppKey = dotenv.env['KAKAO_API_KEY'];
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AuthViewModel()),
    ChangeNotifierProvider(create: (_)=>NovelViewModel()),
    ChangeNotifierProvider(create: (_)=>RecordViewModel()),
  ],
    child:MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            title: 'Flutter Demo',
            home: HomeNav(),
            //MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }
      ),
    );
  }
}