import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/ui/screens/novel/noveldetail_viewmodel.dart';
import 'package:novel_truck/ui/screens/record/newrecord_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../record/record_viewmodel.dart';
import '../record/recorddetail_view.dart';
import 'novel_viewmodel.dart';

class NovelDetail extends StatefulWidget {
  final NovelData novel;
   NovelDetail({super.key, required this.novel});

  @override
  State<NovelDetail> createState() => _NovelDetailState();
}

class _NovelDetailState extends State<NovelDetail> {

  @override
  void initState() {
    super.initState();

    // 현재 프레임이 끝난 후 초기화 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = Provider.of<NovelDetailViewModel>(context, listen: false);
      viewmodel.initialize(int.parse(widget.novel.id));
    });
  }


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
                        widget.novel.imgPath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, size: 50);
                        },
                      ),
                    ),
                    Text(widget.novel.title, style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(height: 10),
                    Wrap(
                      children: [
                       Text('${widget.novel.genreName} ', style: Theme.of(context).textTheme.displayMedium),
                        Text(widget.novel.author, style: Theme.of(context).textTheme.displaySmall),
                      ],
                    ),
                    SizedBox(height:10),
                    ExpandableText(
                      widget.novel.description,
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
                        ...widget.novel.tags.map((tag) {
                        return Chip(
                          label: Text('# ${tag}', style: Theme.of(context).textTheme.displaySmall),
                        );
                      }).toList(),
                        ActionChip(
                          label: Text('+', style: Theme.of(context).textTheme.displaySmall),
                          backgroundColor: Theme.of(context).colorScheme.surface,
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
                                          int.parse(widget.novel.id));
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
                          novel: widget.novel,
                        ),
                      ));
                    }, child: Text('기록하기 / 이어쓰기')),
                  ],
                ),
              ),
              RelateRecordGrid(novelId: widget.novel.id),
            ],
          ),
        ),
      ),
    );
  }
}


class RelateRecordGrid extends StatelessWidget {
  const RelateRecordGrid({super.key, required this.novelId});
  final String novelId;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<NovelDetailViewModel>(context);
    final recordViewmodel = Provider.of<RecordViewModel>(context);


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: viewmodel.isLoading
          ?_buildShimmerGrid()
          :GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
                      child: Text('${viewmodel.recordData[index].content}', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      onPressed: () async {
                        final record = viewmodel.recordData[index];
                        await viewmodel.toggleBookmark(record.id!);

                        final message = record.isBookmarked ? '북마크 추가됨' : '북마크 해제됨';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message), duration: Duration(seconds: 1)),
                        );
                      },
                      icon: viewmodel.recordData[index].isBookmarked
                          ? Icon(Icons.bookmark, color: Theme.of(context).primaryColor)
                          : Icon(Icons.bookmark_border, color: Colors.grey),
                    )

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
        itemCount: viewmodel.recordData.length,
      ),
    );
  }
}


Widget _buildShimmerGrid() {
  return GridView.builder(
    itemCount: 4, // 로딩용 아이템 수
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
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
