import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/record/newrecord_view.dart';
import 'package:provider/provider.dart';


class SelectNovel extends StatelessWidget {
  const SelectNovel({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: '소설 선택'),
              Tab(text: '소설 검색'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBarView(
            children: [
              NovelGrid(),
             Text('소설 검색'),
            ],
          ),
        ),
      ),
    );
  }
}

class NovelGrid extends StatefulWidget {
  const NovelGrid({super.key});

  @override
  State<NovelGrid> createState() => _NovelGridState();
}

class _NovelGridState extends State<NovelGrid> {
  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('소설 선택',style:Theme.of(context).textTheme.displayLarge),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(

                          children: [
                            Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                            Text('${novelViewModel.novelList[index].title}', style: TextStyle(fontSize: 12)),
                          ]),
                    ),
                    onTap: ( ) {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Text('소설 선택'),
                          content: Text('소설을 선택하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                // 소설 선택 로직
                                Navigator.pop(context);
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NewRecord(),
                                ),
                                );
                              },
                              child: Text('확인'),
                            ),
                          ],
                        );
                      });
                    },
                  );
                },
                itemCount: novelViewModel.novelList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
