import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';

class NewRecord3 extends StatelessWidget {
  NewRecord3({super.key});

  final TextEditingController textcontroller = TextEditingController();

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
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 30,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color:AppColors.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Text('3단계',style: TextStyle(color: Colors.white),)),
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
                height: 500,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
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
