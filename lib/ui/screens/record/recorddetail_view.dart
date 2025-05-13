import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/screens/record/record_viewmodel.dart';
import 'package:provider/provider.dart';

class RecordDetail extends StatelessWidget {
  const RecordDetail({super.key, required this.recordIndex});

  final int recordIndex;

  @override
  Widget build(BuildContext context) {
    final recordViewmodel = Provider.of<RecordViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('기록 상세'),
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
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/record_image.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, size: 50);
                        },
                      ),
                    ),
                    Text('소설 제목', style: Theme.of(context).textTheme.displayLarge),

                    SizedBox(height: 20),
                    Text('기록 날짜', style: Theme.of(context).textTheme.displaySmall),
                    SizedBox(height: 10),
                    ElevatedButton(onPressed: (){}, child: Text('기록 수정 / 이어쓰기')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                  width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: recordViewmodel.recordData[recordIndex].isBookmarked
                                ? Icon(Icons.bookmark, color: AppColors.primary,size: 50,)
                                : Icon(Icons.bookmark_border, color: Colors.grey, size: 50),
                            onPressed: () {
                              recordViewmodel.addBookmark(recordIndex);
                              // 북마크 추가/해제 로직
                            },
                          ),
                        ],
                      ),
                    ),
                    Text('${recordViewmodel.recordData[recordIndex].content}', style: Theme.of(context).textTheme.displayMedium),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('이 소설의 다른 기록', style: Theme.of(context).textTheme.displayLarge),
                          SizedBox(height: 10),
                         GridView.builder(
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                             ),
                              padding: EdgeInsets.all(10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: recordViewmodel.recordData.length,
                             itemBuilder: (context, index) {
                               return InkWell(
                                 onTap: () {
                                   // 다른 기록 보기
                                 },
                                 child: Container(
                                   padding: EdgeInsets.all(5),
                                   height: 100,
                                   decoration: BoxDecoration(
                                     color: Colors.white,
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
                               );
                             },)
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
