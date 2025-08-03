
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
           length: 1,
           child: Scaffold(

            body: Column(
              children: [
                SizedBox(height: 20,),
                TabBar(
                  tabs: [
                    Tab(text: '기록모음'),
                    // Tab(text: '북마크'),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TabBarView(
                      children: [
                       RecordGrid(),
                        //BookMarkGrid(),
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
          Container(
            child:CustomTextField(
              label: '검색',
              controller: recordViewmodel.searchController,
              prefixIcon: Icons.search,
              onEditingComplete: () {
                recordViewmodel.searchRecord(recordViewmodel.searchController.text);
              },
            )
          ),
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
                  // Positioned(
                  //   top: 4,
                  //   right: 4,
                  //   child: IconButton(onPressed: (){
                  //     // 북마크 추가/해제
                  //     recordViewmodel.addBookmark(index);
                  //
                  //     // 북마크 추가/해제 시 스낵바 표시
                  //     SnackBar snackBar = SnackBar(
                  //       content: Text(recordViewmodel.recordData[index].isBookmarked ? '북마크 추가됨' : '북마크 해제됨'),
                  //       duration: Duration(seconds: 1),
                  //       backgroundColor: recordViewmodel.recordData[index].isBookmarked ? AppColors.primary : Colors.grey,
                  //     );
                  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //   },
                  //     icon: recordViewmodel.recordData[index].isBookmarked
                  //         ? Icon(Icons.bookmark, color: AppColors.primary,)
                  //         : Icon(Icons.bookmark_border, color: Colors.grey,),
                  //             ),
                  // ),
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

// class BookMarkGrid extends StatelessWidget {
//   const BookMarkGrid({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final recordViewModel = Provider.of<RecordViewModel>(context);
//
//     // 북마크된 데이터만 필터링
//     final bookmarkedData = recordViewModel.recordData.where((record) => record.isBookmarked).toList();
//
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: bookmarkedData.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   //북마크 필터링된 인덱스 넘김
//                   builder: (context) => RecordDetail(recordIndex: recordViewModel.recordData.indexOf(bookmarkedData[index])),
//                 ),
//               ); // NovelDetail( novelIndex: index,novel: recordViewModel.recordData[index],
//             },
//             child: Stack(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(5),
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surface,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 4,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       bookmarkedData[index].content ?? '',
//                       style: const TextStyle(fontSize: 14),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 4,
//                   right: 4,
//                   child: IconButton(
//                     icon: Icon(
//                       bookmarkedData[index].isBookmarked
//                           ? Icons.bookmark
//                           : Icons.bookmark_border,
//                       color: bookmarkedData[index].isBookmarked
//                           ? AppColors.primary
//                           : Colors.grey,
//                     ),
//                     onPressed: () {
//                       final realIndex = recordViewModel.recordData.indexOf(bookmarkedData[index]);
//                       recordViewModel.addBookmark(realIndex);
//
//                       final isNowBookmarked = recordViewModel.recordData[realIndex].isBookmarked;
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(isNowBookmarked ? '북마크 추가됨' : '북마크 해제됨'),
//                           duration: const Duration(seconds: 1),
//                           backgroundColor: isNowBookmarked ? AppColors.primary : Colors.grey,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


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
