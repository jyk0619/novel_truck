import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewRecord3 extends StatelessWidget {
  NewRecord3({super.key});

  final TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
          title: Text('새로운 기록'),
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
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
                                color: Colors.grey,
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
                                color: AppColors.primary,
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
                              child: Center(child: Text('step 3',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text('태그',style: Theme.of(context).textTheme.displaySmall,),
                SizedBox(height: 10,),
                SizedBox(height: 20,),
                Text('내용',style: Theme.of(context).textTheme.displaySmall,),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 500.h,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: TextField(
                    controller: textcontroller,
                    maxLines: null,

                    decoration: InputDecoration(
                      hintText: '자유롭게 작성해주세요!',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20,),


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
                      child: Text('뒤로가기'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewRecord3()));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150.w,40.h),
                      ),
                      child: Text('작성 완료'),
                    ),
                  ],
                ),
              ],
        ),
      ),
      ),
      ),
    );
  }
}
