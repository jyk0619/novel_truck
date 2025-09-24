
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/record/record_viewmodel.dart';
import 'package:novel_truck/ui/screens/record/recorddetail_view.dart';
import 'package:novel_truck/ui/screens/record/selectnovel_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    return
       GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
         child: DefaultTabController(
           length: 2,
           child: Scaffold(

            body: Column(
              children: [
                SizedBox(height: 20,),
                TabBar(
                  tabs: [
                    Tab(text: '기록모음'),
                    Tab(text: '북마크'),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TabBarView(
                      children: [
                       RecordGrid(),
                        BookMarkGrid(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(context: context,
                  barrierDismissible: true,
                  builder: (context) => AlertDialog(
                    insetPadding: EdgeInsets.all(10),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    surfaceTintColor: Colors.transparent,
                    content: SizedBox(
                        child: AddRecord()),
                  ),
                );// Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRecord()));
              },
              child: Icon(Icons.add),
            )
               ),
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

  final _order = ['최신순', '오래된순'];
  String _selectedOrder = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedOrder = _order[0];
    });
  }

  @override
  Widget build(BuildContext context) {

    final recordViewmodel = Provider.of<RecordViewModel>(context);

    return  RefreshIndicator(
      onRefresh: () async {
        // 새로고침 시 데이터 로드
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10,),
          Container(
            child:CustomTextField(
              label: '검색',
              controller: recordViewmodel.recordSearchController,
              prefixIcon: Icons.search,
              onEditingComplete: () {
                recordViewmodel.searchRecord(recordViewmodel.recordSearchController.text);
              },
            )
          ),
          //dropdown filter 추가
          DropdownButton(
            value: _selectedOrder,
              items: _order.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 10)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOrder = value!;
                });
          }),
          Expanded(
            child:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: recordViewmodel.isLoading
      ?_buildShimmerGrid()
          :GridView.builder(
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
                      child: Text('${recordViewmodel.recordData[index].content}', style: TextStyle(fontSize: 14)),
                    ),
                ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(onPressed: (){
                      // 북마크 추가/해제
                      recordViewmodel.fetchBookmark(recordViewmodel.recordData[index].id!);

                      // 북마크 추가/해제 시 스낵바 표시
                      SnackBar snackBar = SnackBar(
                        content: Text(recordViewmodel.recordData[index].isBookmarked ? '북마크 해제됨' : '북마크 추가됨'),
                        duration: Duration(seconds: 1),
                        backgroundColor: recordViewmodel.recordData[index].isBookmarked ? Colors.grey : AppColors.primary,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                      icon: recordViewmodel.recordData[index].isBookmarked
                          ? Icon(Icons.bookmark, color: AppColors.primary,)
                          : Icon(Icons.bookmark_border, color: Colors.grey,),
                              ),
                  ),
                ]
              ),
                  onTap: ( ) {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => RecordDetail(recordIndex:index),
                  )); //NovelDetail( novelIndex: index,novel: recordViewmodel.recordData[index],
                  //탭하면 noveldetail로 이동
                  },
                );
          },
          itemCount: recordViewmodel.recordData.length,
        ),
        ),
          ),
        ],
      ),
    );
  }
}

class BookMarkGrid extends StatelessWidget {
  const BookMarkGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final recordViewModel = Provider.of<RecordViewModel>(context);
    final bookmarkedData = recordViewModel.bookMarkData;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: bookmarkedData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //북마크 필터링된 인덱스 넘김
                  builder: (context) => RecordDetail(recordIndex: recordViewModel.recordData.indexOf(bookmarkedData[index])),
                ),
              ); // NovelDetail( novelIndex: index,novel: recordViewModel.recordData[index],
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: double.infinity,
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
                    child: Text(
                      bookmarkedData[index].content ?? '',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark, color: AppColors.primary
                    ),
                    onPressed: () {
                      // 북마크 해제
                      recordViewModel.fetchBookmark(bookmarkedData[index].id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('북마크 해제됨'),
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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

Widget _buildShimmerGrid() {
  return GridView.builder(
    itemCount: 6, // 로딩용 아이템 수
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    },
  );
}
