import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/core/services/animation_utils.dart';
import 'package:novel_truck/core/theme/app_colors.dart';

class BadgeList extends StatelessWidget {
  const BadgeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 뱃지'),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('닉네임', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(width: 5),
                Text(' 님은', style: Theme.of(context).textTheme.displaySmall),
              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Text('4', style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: AppColors.primary)),
                SizedBox(width: 5),
                Text('개의 뱃지를 모았어요!', style: Theme.of(context).textTheme.displayLarge),
              ],
            ),
            Expanded(
              child: FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  margin: EdgeInsets.all(30.w),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                      itemCount: 4, // Replace with the actual number of badges
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {

                            // Handle badge tap
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                        child: Icon(Icons.star, size: 50, color: AppColors.primary))),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('뱃지 이름', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                        SizedBox(height: 5),
                                        Text('설명', style: TextStyle(fontSize: 12,color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],

                          ),
                          ),
                        );
                      },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
