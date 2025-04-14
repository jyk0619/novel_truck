import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

enum LoginPlatform { google, kakao, apple, none }

class AuthViewModel extends ChangeNotifier {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  LoginPlatform get loginPlatform => _loginPlatform;

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      serverClientId: "407727758351-0g4oqnb90ifhb5ebguilh8u1tghelc4m.apps.googleusercontent.com", // 👈 WebClientId 추가

    ); //웹 클라이언트id 입력 (serverauth )

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');
      print(googleUser);

      _loginPlatform = LoginPlatform.google;
      notifyListeners(); // UI 업데이트
    }
  }

  Future<void> signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print('카카오 로그인 성공: $profileInfo');

      _loginPlatform = LoginPlatform.kakao;
      notifyListeners(); // UI 업데이트

    } catch (error) {
      print('카카오톡 로그인 실패: $error');

    }
  }

  Future<void> signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
      case LoginPlatform.apple:
      case LoginPlatform.none:
        break;
    }
    _loginPlatform = LoginPlatform.none;
    notifyListeners();
  }
}
