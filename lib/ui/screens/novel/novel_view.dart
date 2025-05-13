import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/noveldetail_view.dart';
import 'package:provider/provider.dart';

import 'addnovel_view.dart';

class Novel extends StatelessWidget {
  const Novel({super.key});

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(text: '내 서재'),
                    Tab(text: '소설 검색'),
                  ],
                )
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBarView(
                children: [
                  NovelGrid(),
                  NovelSearch(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>AddNovel()));//소설 추가 페이지로 이동
              },
              child: Icon(Icons.add),
            )
        ),
      );
  }
}

class NovelGrid extends StatefulWidget {
  const NovelGrid({super.key});

  @override
  State<NovelGrid> createState() => _RecordGridState();
}
class _RecordGridState extends State<NovelGrid> {

  @override
  Widget build(BuildContext context) {

final novelViewModel = Provider.of<NovelViewModel>(context);

    return   Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              height: 150.h,
              padding: EdgeInsets.all(5),
              child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text('${novelViewModel.novelList[index].title}', style: TextStyle(fontSize: 12)),
                  ]),
            ),
            onTap: ( ) {
              //탭하면 noveldetail로 이동
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => NovelDetail(
                    novel: novelViewModel.novelList[index],
                  ),
                ),
              );
            },
          );
        },
        itemCount: novelViewModel.novelList.length,
      ),
    );

  }
}

class NovelSearch extends StatelessWidget {
  const NovelSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(label: '검색', controller: TextEditingController(),prefixIcon: Icons.search,);
  }
}
