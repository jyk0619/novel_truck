import  'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';

class CollectionDetail extends StatelessWidget {
  const CollectionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Center(child: Text('제목',style:Theme.of(context).textTheme.displayLarge)),
                ),


                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 50,

                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.divider),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: AppColors.primary, size: 30),
                        Text(' 추가하기',style:Theme.of(context).textTheme.displayMedium),
                      ],
                    ),
                  ),
                  onTap:(){

                  },
                ),

                SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('소설 제목'),
                      subtitle: Text('소설 소개'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){},
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
