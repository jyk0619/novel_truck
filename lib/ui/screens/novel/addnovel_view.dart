import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/addnovel_viewmodel.dart';
import 'package:provider/provider.dart';
import 'novel_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';

class AddNovel extends StatelessWidget {
  AddNovel({super.key, required this.sharedurl});

  final String sharedurl;

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<AddNovelViewModel>(context);

    // URL 추출
    var urlLine = sharedurl.split('\n').firstWhere(
          (line) => line.trim().startsWith('http'),
      orElse: () => '',
    );

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('플랫폼에서 등록할 소설 찾기',
                  style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 20),
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // 네이버 시리즈 링크로 이동
                        PlatformLauncher('series');
                        //launchPlatform('series');
                      },
                      child: Container(
                        child:Column(
                          children:[
                            Icon(Icons.link, size: 30, color: Colors.green),
                            SizedBox(height: 5),
                            Text('네이버 시리즈', style: TextStyle(fontSize: 16)),
                          ]

                        )
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        // 문피아로 이동
                        PlatformLauncher('munpia');
                      },
                      child: Container(
                        child:Column(
                          children:[
                            Icon(Icons.link, size: 30, color: Colors.lightBlue),
                            SizedBox(height: 5),
                            Text('문피아', style: TextStyle(fontSize: 16)),
                          ]

                        )
                      ),
                    ),
                    
                    InkWell(
                      onTap: () {
                        // 조아라 링크로 이동
                        PlatformLauncher('joara');
                      },
                      child: Container(
                        child:Column(
                          children:[
                            Icon(Icons.link, size: 30, color: Colors.blue),
                            SizedBox(height: 5),
                            Text('조아라', style: TextStyle(fontSize: 16)),
                          ]

                        )
                      ),
                    ),

                  ]
                ),
              ),
              SizedBox(height: 20),
              Text('소설 URL을 입력하거나 공유된 링크를 사용하세요',
                  style: Theme.of(context).textTheme.displaySmall),
              Text('$urlLine', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 10),
              CustomTextField(label: '소설 URL을 입력하세요',
                  controller: novelViewModel.novelUrlController
                  ..text = urlLine, // 공유된 URL을 초기값으로 설정
                  prefixIcon: Icons.link,
                  onChanged: () {
                    urlLine = novelViewModel.novelUrlController.text;
                  },
                  onEditingComplete: () {
                    urlLine=novelViewModel.novelUrlController.text;
                  },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    print(urlLine);
                    if (urlLine.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('소설 URL을 찾을 수 없습니다')),
                      );
                      return;
                    }

                    // 로딩 다이얼로그 먼저 띄움
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => Center(child: CircularProgressIndicator()),
                    );

                    // 비동기 처리
                    await novelViewModel.submitNovelUrl(urlLine.trim());

                    // 로딩 다이얼로그 닫기
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('소설이 등록되었습니다 !')),
                    );

                    // 결과 다이얼로그 띄우기
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('등록 소설 정보', style: Theme.of(context).textTheme.titleMedium),
                          content: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  novelViewModel.novelImage ?? '',
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      color: Colors.grey[300],
                                      child: Center(child: Text('이미지를 불러올 수 없습니다')),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                Text('소설 제목: ${novelViewModel.novelTitle ?? '제목 없음'}'),
                                Text('소설 장르 : ${novelViewModel.novelGenreName ?? '장르 없음'}'),
                                Text('소설 ID: ${novelViewModel.novelId ?? 'ID 없음'}'),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('닫기'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                child: Text('소설 등록', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class PlatformInfo {
  final String packageName;
  final String iosFallbackUrl;

  const PlatformInfo({
    required this.packageName,
    required this.iosFallbackUrl,
  });
}

// 각 플랫폼 별 정보
const Map<String, PlatformInfo> platforms = {
  'series': PlatformInfo(
    packageName: 'com.nhn.android.nbooks',
    iosFallbackUrl: 'https://series.naver.com',
  ),
  'joara': PlatformInfo(
    packageName: 'com.joara.mobile',
    iosFallbackUrl: 'https://www.joara.com',
  ),
  'munpia': PlatformInfo(
    packageName: 'kr.munpia.forandroid',
    iosFallbackUrl: 'https://m.munpia.com',
  ),
};


void PlatformLauncher(String key) async {
  final info = platforms[key];
  bool success = await NativeLauncher.launchApp(info!.packageName);
  if (!success) {
    // 네이버 시리즈 앱이 설치되어 있지 않으면 Play Store로 이동
    final url = Uri.parse('https://play.google.com/store/apps/details?id=${info.packageName}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('앱을 설치할 수 없습니다.');
    }
    print('앱 실행 실패!');
  }
}

// 네이티브 앱 실행을 위한 메소드 채널
class NativeLauncher {
  static const  _channel = MethodChannel('com.example.novel_truck/launcher');

  static Future<bool> launchApp(String packageName) async {
    try {
      final bool result = await _channel.invokeMethod('launchApp', {'packageName': packageName});
      return result;
    } on PlatformException catch (e) {
      print('Error launching app: ${e.message}');
      return false;
    }
  }
}
