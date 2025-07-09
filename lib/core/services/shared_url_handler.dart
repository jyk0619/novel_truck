// lib/core/services/shared_url_handler.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:novel_truck/ui/screens/novel/addnovel_view.dart';
import 'package:flutter/foundation.dart'; // kIsWeb 플래그

class SharedUrlHandler {
  final GlobalKey<NavigatorState> navigatorKey;

  SharedUrlHandler(this.navigatorKey);

  StreamSubscription? _streamSub;

  void init() {
    if(kIsWeb) return;
    // 앱이 켜져 있을 때 공유 받는 경우
    _streamSub = ReceiveSharingIntent.instance.getMediaStream().listen(
          (List<SharedMediaFile> value) {
        if (value.isNotEmpty) {
          _navigateToSharedPage(value.first.path);
        }
      },
      onError: (err) {
        debugPrint("getMediaStream error: $err");
      },
    );

    // 앱이 꺼져 있을 때 공유로 실행된 경우
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      if (value != null && value.isNotEmpty) {
        _navigateToSharedPage(value.first.path);
        ReceiveSharingIntent.instance.reset(); // 처리 완료 알림
      }
    });
  }

  void _navigateToSharedPage(String url) {
    // 앱이 완전히 렌더된 이후에 페이지 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => AddNovel(sharedurl: url),
        ),
      );
    });
  }

  void dispose() {
    _streamSub?.cancel();
  }
}
