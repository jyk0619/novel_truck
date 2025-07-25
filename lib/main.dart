import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/screens/auth/ezsignup_view.dart';
import 'package:novel_truck/ui/screens/auth/login_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/addnovel_view.dart';
import 'package:novel_truck/ui/screens/novel/addnovel_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/collection_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/onboarding/onboarding_view.dart';
import 'package:novel_truck/ui/screens/record/record_viewmodel.dart';
import 'package:provider/provider.dart';

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
import 'package:novel_truck/core/services/shared_url_handler.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/theme_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late SharedUrlHandler sharedUrlHandler;

void main() async{
  // 외부 공유받기
  WidgetsFlutterBinding.ensureInitialized();
  sharedUrlHandler = SharedUrlHandler(navigatorKey);
  sharedUrlHandler.init();// 초기화 시 공유 인텐트 감지 시작

  await dotenv.load(fileName:"assets/config/.env");
  String? kakaoNativeAppKey = dotenv.env['KAKAO_API_KEY'];
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AuthViewModel()),
    ChangeNotifierProvider(create: (_)=>NovelViewModel()),
    ChangeNotifierProvider(create: (_)=>RecordViewModel()),
    ChangeNotifierProvider(create: (_)=>ThemeProvider()),
    ChangeNotifierProvider(create: (_)=>AddNovelViewModel()),
    ChangeNotifierProvider(create: (_)=>CollectionViewModel()),
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
      designSize: Size(412, 732),
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            title: 'Flutter Demo',
            //MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }
      ),
    );
  }
}



final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeNav(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
        path: '/auth/agree',
        builder: (context, state) => Agree()
    ) ,// 간편 회원가입 화면
    GoRoute(
        path: '/auth/signup',
        builder: (context, state) => EzSignUp()),
    GoRoute(
        path: '/auth/signupcom',
        builder: (context, state) => SignUpCom()),

    GoRoute(
      path: '/addnovel',
      builder: (context, state) => AddNovel(sharedurl: '',),
    )
    // 추가 라우트들...
  ],
);
