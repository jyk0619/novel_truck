import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    return
       DefaultTabController(
         length: 3,
         child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: '기록모음'),
                Tab(text: '북마크'),
                Tab(text: '기록검색'),
              ],
            )
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: [
               RecordGrid(),
                BookMarkGrid(),
                RecordSearch(),
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

class RecordGrid extends StatefulWidget {
  const RecordGrid({super.key});

  @override
  State<RecordGrid> createState() => _RecordGridState();
}
class _RecordGridState extends State<RecordGrid> {

  @override
  Widget build(BuildContext context) {

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child:DropdownButton(items: [
            DropdownMenuItem(child: Text('최신순'), value: '전체',),
            DropdownMenuItem(child: Text('가나다순'), value: '웹소설',),
            DropdownMenuItem(child: Text('기본순'), value: '기본순',),
            DropdownMenuItem(child: Text('소설'), value: '소설',),
          ], onChanged: (value){},),
        ),
        Expanded(
          child: GridView(gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: [
              Card(child: Text('기록1')),
              Card(child: Text('기록2')),
              Card(child: Text('기록3')),
              Card(child: Text('기록4')),
              Card(child: Text('기록5')),
              Card(child: Text('기록6')),
              Card(child: Text('기록7')),
              Card(child: Text('기록1')),
              Card(child: Text('기록2')),
              Card(child: Text('기록3')),
              Card(child: Text('기록4')),
              Card(child: Text('기록5')),
              Card(child: Text('기록6')),
              Card(child: Text('기록7')),
            ],),
        ),
      ],
    );

  }
}

class BookMarkGrid extends StatelessWidget {
  const BookMarkGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(gridDelegate:
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      children: [
        Card(child: Text('북마크1')),
        Card(child: Text('북마크2')),
        Card(child: Text('북마크3')),
        Card(child: Text('북마크4')),
        Card(child: Text('북마크5')),

      ],);
  }
}

class RecordSearch extends StatelessWidget {
  const RecordSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(label: '검색', controller: TextEditingController(),prefixIcon: Icons.search,);
  }
}
