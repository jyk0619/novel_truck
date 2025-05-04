import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionAdd extends StatefulWidget {

   CollectionAdd({super.key});

  @override
  State<CollectionAdd> createState() => _CollectionAddState();
}

class _CollectionAddState extends State<CollectionAdd> {
   TextEditingController title = TextEditingController();

    String imagePath = 'assets/images/novel1.jpg';

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);
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
                width: 200.w,
                height: 200.h,
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
                    ElevatedButton(onPressed: (){
                      novelViewModel.addCollection(title.text, imagePath);
                      Navigator.pop(context);
                    }, child: Text('생성')),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
