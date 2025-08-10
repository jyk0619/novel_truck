import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/ui/screens/record/newrecord_view.dart';
import 'package:provider/provider.dart';

import 'novel_viewmodel.dart';

class NovelDetail extends StatelessWidget {
  final NovelData novel;
   NovelDetail({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<NovelViewModel>(context);

    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        title: Text('소설 정보'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        novel.imgPath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, size: 50);
                        },
                      ),
                    ),
                    Text(novel.title, style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(height: 10),
                    Wrap(
                      children: [
                       Text('${novel.genreName} ', style: Theme.of(context).textTheme.displayMedium),
                        Text(novel.author, style: Theme.of(context).textTheme.displaySmall),
                      ],
                    ),
                    SizedBox(height:10),
                    ExpandableText(
                      novel.description,
                      expandText: '더보기',
                      collapseText: '접기',
                      maxLines: 3,
                      style: Theme.of(context).textTheme.displaySmall,
                      linkColor: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:[
                        ...novel.tags.map((tag) {
                        return Chip(
                          label: Text('# ${tag}', style: Theme.of(context).textTheme.displaySmall),
                        );
                      }).toList(),
                        ActionChip(
                          label: Text('+', style: Theme.of(context).textTheme.displaySmall),
                          backgroundColor: Theme.of(context).colorScheme.background,
                          onPressed: () {
                            showDialog(context: context,
                                builder: (context)=>
                              AlertDialog(
                                title: Text('태그 추가'),
                                content: TextField(
                                  controller: viewmodel.tagController,
                                  decoration: InputDecoration(
                                    hintText: '태그를 입력하세요',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('추가'),
                                    onPressed: () async{
                                      await viewmodel.addTag(
                                          viewmodel.tagController.text,
                                          int.parse(novel.id));
                                      viewmodel.tagController.clear();

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('태그가 추가되었습니다.'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                      Navigator.of(context).pop();

                                    },
                                  ),
                                ]
                              )
                            );
                            // 태그 추가 기능 구현
                          },
                        ),
                      ]
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: (){
                      // 기록 수정 / 이어쓰기
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NewRecord(
                          novel: novel,
                        ),
                      ));
                    }, child: Text('기록하기 / 이어쓰기')),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text('이 소설의 기록', style: Theme.of(context).textTheme.displayLarge),
                            SizedBox(height: 10),
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:3 ,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // 다른 기록 보기
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text('d', style: TextStyle(fontSize: 14)),
                                    ),
                                  ),
                                );
                              },)
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

