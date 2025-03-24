import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/core/theme/app_images.dart';
import 'package:novel_truck/ui/screens/auth/ezsignup_view.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {

  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      setState(() {
        _loginPlatform = LoginPlatform.google;
      });
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text('간편 회원가입', style: Theme.of(context).textTheme.displaySmall),
                    Text('기록을\n시작해볼까요?',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: AppColors.primary),),
                  ],
                )
              ),
              const SizedBox(height: 20),
              Container(
                width: 200 ,
                height: 200,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFFFAE100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(AppImages.klogo,)),
                            Text('카카오 계정으로 로그인', style: TextStyle(color: Colors.black),),
                          ],
                        )),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EzSignUp() ));
                    }
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(AppImages.glogo,fit: BoxFit.fill)),
                            Text('Google 계정으로 로그인', style: TextStyle(color: Colors.black),),
                          ],
                        )),
                    onTap: () {
                      signInWithGoogle();
                    }
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(AppImages.alogo,fit: BoxFit.fill,)),
                          Text('Apple 계정으로 로그인', style: TextStyle(color: Colors.white),),
                        ],
                      )),
                  Text('현재 로그인 상태 : $_loginPlatform', style: TextStyle(fontSize: 20),),
                  ElevatedButton(
                    onPressed: () {
                      signOut();
                    },
                    child: const Text('로그아웃'),
                  ),
                ],
              ),

            ],
          ),
        )
      ),
    );
  }
}

enum LoginPlatform {
  google,
  kakao,
  apple,
  none,
}
