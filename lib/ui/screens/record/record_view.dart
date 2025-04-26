
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/record/record_viewmodel.dart';
import 'package:novel_truck/ui/screens/record/selectnovel_view.dart';
import 'package:provider/provider.dart';


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
            onPressed: (){
              showDialog(context: context,
                barrierDismissible: true,
                builder: (context) => AlertDialog(
                  insetPadding: EdgeInsets.all(10),
                  backgroundColor: AppColors.background,
                  surfaceTintColor: Colors.transparent,
                  content: SizedBox(
                      child: AddRecord()),
                ),
              );// Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRecord()));
            },
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

    final recordViewmodel = Provider.of<RecordViewModel>(context);

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
          child:
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
           itemBuilder: (context, index) {
            return InkWell(
            child: Stack(
              children:[
              Container(
                padding: EdgeInsets.all(5),
                  height: double.infinity,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  ),
                  child: Center(
                    child: Text('${recordViewmodel.recordData[index].content}', style: TextStyle(fontSize: 14)),
                  ),
              ),
                IconButton(onPressed: (){
                  // 북마크 추가/해제
                  recordViewmodel.addBookmark(index);

                  // 북마크 추가/해제 시 스낵바 표시
                  SnackBar snackBar = SnackBar(
                    content: Text(recordViewmodel.recordData[index].isBookmarked ? '북마크 추가됨' : '북마크 해제됨'),
                    duration: Duration(seconds: 1),
                    backgroundColor: recordViewmodel.recordData[index].isBookmarked ? AppColors.primary : Colors.grey,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                  icon: recordViewmodel.recordData[index].isBookmarked
                      ? Icon(Icons.bookmark, color: AppColors.primary,)
                      : Icon(Icons.bookmark_border, color: Colors.grey,),
          ),
              ]
            ),
                onTap: ( ) {

                //탭하면 noveldetail로 이동
                },
              );
        },
        itemCount: recordViewmodel.recordData.length,
      ),
      ),
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
      ],
    );
  }
}

class RecordSearch extends StatelessWidget {
  const RecordSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(label: '검색',
      controller: TextEditingController(),
      prefixIcon: Icons.search,);
  }
}

class AddRecord extends StatelessWidget {
  const AddRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('기록 추가', style: Theme.of(context).textTheme.titleMedium),
            ),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => SelectNovel(),
                ),
              );
            },
              child: Text('내 서재로 가기'),
            ),
            SizedBox(height: 10),
            Text('내 서재에서 소설을 선택해주세요', style: Theme.of(context).textTheme.displaySmall),
            // Add your form fields here
          ],
        ),
      ),
    );
  }
}
