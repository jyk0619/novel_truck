import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/noveldetail_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
              automaticallyImplyLeading: false,
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
                MaterialPageRoute(builder: (context)=>AddNovel(sharedurl: 'http://naver.me/FMc3GAvf',)));//소설 추가 페이지로 이동
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
      child: novelViewModel.isLoading
      ? _buildShimmeringGrid()
          :GridView.builder(
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

Widget _buildShimmeringGrid() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: Container(
          height: 150.h,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    },
    itemCount: 6, // 예시로 6개의 아이템
  );
}