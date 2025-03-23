import 'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/record/newrecord2_view.dart';

import '../../../core/theme/app_colors.dart';

class NewRecord extends StatelessWidget {
  const NewRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
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
                    Icon(Icons.book,size: 100,color: AppColors.primary,),
                  ],
                )
            ),
            Container(
              width:200,
              height: 300,
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
                    minimumSize: Size(150,40),
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                child: Text('나가기'),
              ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewRecord2()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150,40),
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
