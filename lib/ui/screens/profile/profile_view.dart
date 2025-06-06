import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/screens/profile/badgelist_view.dart';
import 'package:novel_truck/core/services/animation_utils.dart';

import '../novel/collection_view.dart';


class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text('마이페이지', style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('닉네임', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(width: 5),
                    Text(' 님', style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 130.h,
                padding: EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                   SizedBox(
                     width: double.infinity,
                     child:Text('오늘까지',style: Theme.of(context).textTheme.displaySmall),
                   ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              'assets/images/books_icon.svg',
                              height: 50.h,
                            ),
                          ),
                          SizedBox(
                            child:Row(
                              children: [
                                NumberCounter(
                                  start: 0,
                                  end: 12,
                                  textStyle: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: AppColors.primary),
                                ),
                                Text('\n 권의 책을 기록했어요.', style: Theme.of(context).textTheme.displaySmall),
                              ],
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => BadgeList(), //Replace with your badge detail page
                    ),
                  );
                  // Navigate to badge detail page
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child:Row(
                          children:[
                            NumberCounter(start: 0, end: 4,
                                textStyle: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text('\n 개의 뱃지를 모았어요.', style: TextStyle(fontSize: 14, color: Colors.white)),
                          ],
                        )
                      ),
                      SizedBox(
                        child:Row(
                          children:[
                            SvgPicture.asset(
                              'assets/images/badge_icon.svg',
                              height: 50.h,
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                          ],
                        )
                      )
                    ],
                  )
                ),
              ),
              SizedBox(height:10),
              InkWell(
                onTap: () {
                 Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => Collection(), //Replace with your playlist detail page
                    ),
                 );
                  // Navigate to playlist detail page
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: AppColors.primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            child:Row(
                              children:[
                                NumberCounter(start: 0, end: 1,
                                    textStyle: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: Colors.white)),
                                Text('\n 개의 플레이리스트를 만들었어요.', style: TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            )
                        ),
                        SizedBox(
                            child:Row(
                              children:[
                                SvgPicture.asset(
                                  'assets/images/playlist_icon2.svg',
                                  height: 50.h,
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.white),
                              ],
                            )
                        )
                      ],
                    )
                ),
              ),
              Container(

                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [

                    ListTile(
                      title: Text('내 정보'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text('이용약관'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text('설정'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Text('로그아웃', style: TextStyle(color: Colors.red)),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

