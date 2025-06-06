import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_truck/ui/screens/record/newrecord2_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class NewRecord extends StatelessWidget {
  const NewRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
        title: Text('새로운 기록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox
              (width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('기록하기',style:Theme.of(context).textTheme.displayLarge),
                  SizedBox(
                    child:Row(
                      children:[
                        Container(
                          width: 20.w,
                          height: 20.h,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 20.h,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 20.h,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 80.w,
                          height: 30.h,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text('step 1',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))),
                        ),
                      ]
                    )
                  )
                ],
              ),
            ),
            SizedBox(height:30),
            SizedBox(
              width: double.infinity,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('지금 이 소설을'
                        '\n기록할까요?',style: Theme.of(context).textTheme.titleLarge),
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: SvgPicture.asset(
                        'assets/images/bookicon.svg',
                        height: 100.h,
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 30),
            Container(
              width:200.w,
              height: 300.h,
              color: Colors.grey,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w,40.h),
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                child: Text('나가기'),
              ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => NewRecord2(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );


                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w,40.h),
                  ),
                  child: Text('다음 단계로'),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
