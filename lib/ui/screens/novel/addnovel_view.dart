import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'novel_viewmodel.dart';

class AddNovel extends StatelessWidget {
  AddNovel({super.key, required this.sharedurl});

  final String sharedurl;

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);

    // URL 추출
    final urlLine = sharedurl.split('\n').firstWhere(
          (line) => line.trim().startsWith('http'),
      orElse: () => '',
    );

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('$urlLine', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 10),
            Text('소설 제목을 입력하세요', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print(urlLine);
                if (urlLine.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('소설 URL을 찾을 수 없습니다')),
                  );
                  return;
                }

                if (novelViewModel.isLoading) {
                  showDialog(
                    context: context,
                    builder: (context) => Center(child: CircularProgressIndicator()),
                  );
                  return;
                }

                novelViewModel.submitNovelUrl(urlLine.trim());


               showDialog(context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(novelViewModel.novelImage ?? '',
                                height: 200.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10),
                              Text('소설 제목: ${novelViewModel.novelTitle ?? '제목 없음'}'),
                              SizedBox(height: 10),
                              Text('등록하시겠습니까?',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                              onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text('취소')
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('소설이 등록되었습니다')),
                              );
                            },
                            child: Text('등록'),
                          ),
                        ],
                      );
                    }
                );
              },
              child: Text('요청'),
            ),

            SizedBox(height: 10),
            if (novelViewModel.isLoading)
              CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}
