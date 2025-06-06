// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:novel_truck/core/theme/app_colors.dart';
//
// class RecordGuide extends StatelessWidget {
//    RecordGuide({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         scrollDirection: Axis.vertical,
//         children: const [
//           FullScreenSection(color: AppColors.background, textColor: AppColors.textPrimary, text: "Page 1", imagePath: 'assets/images/recordguide1.svg'),
//           FullScreenSection(color: Colors.black54, textColor: AppColors.textWhite,text: "Page 2", imagePath: 'assets/images/recordguide2.svg'),
//           FullScreenSection(color: AppColors.background, textColor: AppColors.textPrimary,text: "Page 3", imagePath: 'assets/images/recordguide3.svg'),
//           FullScreenSection(color: Colors.black54, textColor: AppColors.textWhite,text: "Page 4", imagePath: 'assets/images/recordguide4.svg'),
//           FullScreenSection(color: AppColors.background,textColor: AppColors.textPrimary, text: "Page 5", imagePath: 'assets/images/recordguide5.svg'),
//         ],
//       ),
//     );
//   }
// }
//
// class FullScreenSection extends StatelessWidget {
//   final Color color;
//   final String text;
//   final String imagePath;
//   final Color textColor;
//
//   const FullScreenSection({
//     super.key,
//     required this.color,
//     required this.textColor,
//     required this.text,
//     required this.imagePath,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             SizedBox(height: 20.h),
//             SvgPicture.asset('$imagePath', fit: BoxFit.cover, width: 400.w, height: 400.h),
//             const SizedBox(height: 20),
//             Text(text, style: TextStyle(fontSize: 32, color: textColor)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_truck/core/theme/app_colors.dart';

class RecordGuide extends StatelessWidget {
  const RecordGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        iconTheme: IconThemeData(color: AppColors.textWhite),

        title: Text('소설 기록하는 방법',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textWhite)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.h),
              color: Colors.black,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/recordguide0.svg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "소설 하나 하나\n 제대로 기억하고싶은\n 당신을 위한 ",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "기록 가이드",
                      style: TextStyle(color: AppColors.textWhite,fontWeight: FontWeight.bold,fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            FullScreenSection(
              index:"1",
              color: AppColors.background,
              textColor: AppColors.textPrimary,
              text: "소설 플랫폼에서 기록하고싶은 소설을 선택해 해당 소설의 공유하기 버튼을 눌러주세요.",
              imagePath: 'assets/images/recordguide1.svg',
            ),

            FullScreenSection(
              index:"2",
              color: Colors.black,
              textColor: AppColors.textWhite,
              text: "공유할 어플리케이션에 해당 어플을 선택해주세요.",
              imagePath: 'assets/images/recordguide2.svg',
            ),
            FullScreenSection(
              index:"3",
              color: AppColors.background,
              textColor: AppColors.textPrimary,
              text: "기록하고자 하는 소설이 맞으면 다음단계로 넘어가주세요.",
              imagePath: 'assets/images/recordguide3.svg',
            ),

            FullScreenSection(
              index:"4",
              color: Colors.black,
              textColor: AppColors.textWhite,
              text: "소설에 맞는 태그, 내가 기록하고싶은 태그를 입력해주세요.",
              imagePath: 'assets/images/recordguide4.svg',
            ),

            FullScreenSection(
              index:"5",
              color: AppColors.background,
              textColor: AppColors.textPrimary,
              text: "기록하고싶은 내용들을 자유롭게 기록해주면 끝!",
              imagePath: 'assets/images/recordguide5.svg',
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.h),
              color: Colors.black,
              child: Column(
                children: [
                  Text('등록 후에는 . . .',style:TextStyle(color: AppColors.textWhite,fontWeight: FontWeight.bold,fontSize: 32)),
                  SizedBox(height: 20.h),
                  SvgPicture.asset(
                    'assets/images/recordguide6.svg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                      child: Text('한번 등록을 완료하면\n 내 서재에서 등록한 소설을 찾아 기록을 추가하거나 수정할 수 있어요!',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center),),
                  SizedBox(height: 20.h),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text('소설을 등록하고, 기록하면서\n다양한 뱃지들을 획득해보세요!',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center),),
                  SizedBox(height: 20.h),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/recordguide7.svg',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.8,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 700.h, // 그라데이션 영역 높이 조정 가능
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,        // 위쪽: 투명
                                Colors.black,      // 아래쪽: 배경색
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FullScreenSection extends StatelessWidget {
  final Color color;
  final String text;
  final String imagePath;
  final Color textColor;
  final String index;

  const FullScreenSection({
    super.key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: TextStyle(fontSize: 20, color: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SvgPicture.asset(imagePath, fit: BoxFit.cover, width: 300.w, height: 300.h),
          SizedBox(height: 20.h),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
