import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/screens/auth/login_view.dart';
import 'package:novel_truck/ui/screens/home/homenav_view.dart';


class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntroductionScreen(

          pages: [
            PageViewModel(
              useScrollView: false,
              title: "",
              bodyWidget: Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/onboarding1.svg',
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      bottom: 0,
                        child: Text("다양한 소설들을 등록하고 \n 자유롭게, 내마음대로 기록해보세요.",textAlign:TextAlign.center, style: Theme.of(context).textTheme.titleSmall)),
                  ],
                ),
              ),
            ),
            PageViewModel(
              useScrollView: false,
              title: "",
              bodyWidget: Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/onboarding2.svg',
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text("기록한 소설들은\n기록 모음, 내 서재에서 한번에\n모아 볼 수 있습니다.", textAlign:TextAlign.center,style: Theme.of(context).textTheme.titleSmall)),
                  ],
                ),
              ),
            ),
            PageViewModel(
              useScrollView: false,
              title: "",
              bodyWidget: Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/onboarding3.svg',
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text("등록한 소설들을 바탕으로\n나만의 <소설 플레이리스트>를\n만들어보세요!", textAlign:TextAlign.center,style: Theme.of(context).textTheme.titleSmall)),
                  ],
                ),
              ),
            ),
            PageViewModel(
              useScrollView: false,
              title: "",
              bodyWidget: Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/onboarding4.svg',
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text("기록하는 내용, 기록 횟수에 따라\n부여되는 다영한 뱃지를\n모아보세요!", textAlign:TextAlign.center,style: Theme.of(context).textTheme.titleSmall)),
                  ],
                ),
              ),
            ),
            PageViewModel(
              useScrollView: false,
              title: "",
              bodyWidget: Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/onboarding5.svg',
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text("기록한 소설, 획득한 뱃지,\n작성한 플레이리스트 등은\n마이페이지에서 모아 볼 수 있어요.",textAlign:TextAlign.center, style: Theme.of(context).textTheme.titleSmall)),
                  ],
                ),
              ),
            ),
          ],

          controlsMargin: const EdgeInsets.all(0),
          controlsPadding: const EdgeInsets.all(0),
          onDone: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeNav(),
              ),
            );
          },
          onSkip: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeNav(),
              ),
            );
          },
          showSkipButton: true,
          skip: const Text("건너뛰기"),
          next: const Icon(Icons.arrow_forward),
          done: const Text("시작하기"),
            ),
      ),

    );

  }
}
