import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('닉네임', style: Theme.of(context).textTheme.displayLarge),
                    Text(' 님', style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
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
                          Icon(Icons.book, size: 50, color: AppColors.primary),
                          SizedBox(
                            child:Row(
                              children: [
                                Text('12', style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: AppColors.primary)),
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
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 100,
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
                          Text('4', style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: Colors.white)),
                          Text('\n 개의 뱃지를 모았어요.', style: TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      )
                    ),
                    SizedBox(
                      child:Row(
                        children:[
                          Icon(Icons.local_police_outlined, color: Colors.blueAccent, size: 50),
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ],
                      )
                    )
                  ],
                )
              ),
              SizedBox(height:10),
              Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 100,
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
                              Text('1', style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: Colors.white)),
                              Text('\n 개의 플레이리스트를 만들었어요.', style: TextStyle(fontSize: 14, color: Colors.white)),
                            ],
                          )
                      ),
                      SizedBox(
                          child:Row(
                            children:[
                              Icon(Icons.play_circle_fill_outlined, color: Colors.white, size: 50),
                              Icon(Icons.arrow_forward_ios, color: Colors.white),
                            ],
                          )
                      )
                    ],
                  )
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
