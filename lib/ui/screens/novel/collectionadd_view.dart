import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';

class CollectionAdd extends StatelessWidget {
   CollectionAdd({super.key});

   final  TextEditingController title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text('컬렉션 추가',style: Theme.of(context).textTheme.titleLarge),
              ),

              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: IconButton(icon: Icon(Icons.add), onPressed: (){}),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(label: '플레이리스트 이름을 입력해주세요', controller: title,)
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text('취소')
                    ),
                    ElevatedButton(onPressed: (){}, child: Text('생성')),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
