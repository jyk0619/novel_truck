import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';

class Novel extends StatelessWidget {
  const Novel({super.key});

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(text: '내 서재'),
                    Tab(text: '컬렉션'),
                    Tab(text: '소설 검색'),
                  ],
                )
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBarView(
                children: [
                  NovelGrid(),
                  Text('컬렉션'),
                  NovelSearch(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
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

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child:DropdownButton(items: [
            DropdownMenuItem(child: Text('최신순'), value: '최신순',),
            DropdownMenuItem(child: Text('가나다순'), value: '웹소설',),
            DropdownMenuItem(child: Text('기본순'), value: '기본순',),
            DropdownMenuItem(child: Text('소설'), value: '소설',),
          ], onChanged: (value){},),
        ),
        Expanded(
          child: GridView(gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: [
              Card(child: Text('소설')),
             
            ],),
        ),
      ],
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
