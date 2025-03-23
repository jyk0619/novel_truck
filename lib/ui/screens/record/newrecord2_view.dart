import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/record/newrecord3_view.dart';

class NewRecord2 extends StatelessWidget {
   NewRecord2({super.key});

  final TextEditingController tagcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새로운 기록'),
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
                            margin: const EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
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
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('step 2', style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('태그를\n추가해주세요.',style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.tag,size: 100,color: AppColors.primary,),
                ],
              ),
              SizedBox(height: 20,),
              Text('많이 찾는 태그',style: Theme.of(context).textTheme.displayMedium),
              SizedBox(height: 10,),
              Row(
                children:[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('로맨스',style: TextStyle(color: AppColors.textSecondary,fontSize: 16)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('판타지',style: TextStyle(color: AppColors.textSecondary,fontSize: 16)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('태그',style: TextStyle(color: AppColors.textSecondary,fontSize: 16)),
                    ),
                  ),
                ]
              ),
              SizedBox(height: 20,),
              Text('태그 직접 입력하기',style: Theme.of(context).textTheme.displayMedium),
              SizedBox(height: 10,),
              Container(
                width: 200,
                height: 40,
                child:Row(
                  children: [
                    Expanded(child: CustomTextField(label: '태그', controller: tagcontroller, prefixIcon: Icons.tag)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.add_circle,color: AppColors.primary,size: 30,)),
                  ],
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
                      minimumSize: Size(150,40),
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text('나가기'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewRecord3()));
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
        ),
      ),
    );
  }
}
