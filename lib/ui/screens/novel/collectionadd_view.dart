
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/collection_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CollectionAdd extends StatefulWidget {

   CollectionAdd({super.key});

  @override
  State<CollectionAdd> createState() => _CollectionAddState();
}

class _CollectionAddState extends State<CollectionAdd> {
   TextEditingController title = TextEditingController();
    String imagePath = '';

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<CollectionViewModel>(context);
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
                child:
                  imagePath!=''
                      ? Image.file( File(imagePath), fit: BoxFit.cover)
                  :IconButton(icon: Icon(Icons.add), onPressed: (){
                  imagePicker().then((value) {
                    setState(() {
                      imagePath = value;
                      print('imagePath: $imagePath');
                    });
                  });
                }),
              ),

              Container(

                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: title,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '플레이리스트 이름을 입력해주세요',
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ),
                //CustomTextField(label: '플레이리스트 이름을 입력해주세요', controller: title,)
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
                    ElevatedButton(
                      onPressed: () async {
                        if (title.text.isNotEmpty && imagePath.isNotEmpty) {
                          await viewmodel.submitCollection(title.text, File(imagePath));
                          print('등록 완료');
                          viewmodel.initialize();
                          Navigator.pop(context);
                        } else {
                          print('제목 또는 이미지 누락');
                        }
                      },
                      child: Text('생성'),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}


Future<String> imagePicker() async{
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    // Use the selected image
    String _imagePath = image.path;
    print('Selected image path: $_imagePath');
    return _imagePath;
    // You can also display the image in your UI using Image.file(File(imagePath))
  } else {
    print('No image selected.');
    return '';
  }
}