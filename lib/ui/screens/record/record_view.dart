import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
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
        body: TabBarView(
          children: [
           RecordGrid(),
            BookMarkGrid(),
            RecordSearch(),
          ],
        ),
      ),
    ) );
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
      children: [
        GridView(gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: [
            Center(child: Text('기록1')),
            Center(child: Text('기록2')),
            Center(child: Text('기록3')),
            Center(child: Text('기록4')),
            Center(child: Text('기록5')),
            Center(child: Text('기록6')),
            Center(child: Text('기록7')),
            Center(child: Text('기록8')),
            Center(child: Text('기록9')),
            Center(child: Text('기록10')),
          ],),
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
        Center(child: Text('북마크1')),
        Center(child: Text('북마크2')),
        Center(child: Text('북마크3')),
        Center(child: Text('북마크4')),
        Center(child: Text('북마크5')),
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
