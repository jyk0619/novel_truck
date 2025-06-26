import 'package:flutter/material.dart';
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
            Text('$urlLine', style: Theme.of(context).textTheme.headline6),
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

                novelViewModel.submitNovelUrl(urlLine.trim());
              },
              child: Text('요청'),
            ),
            SizedBox(height: 10),
            Text('요청결과'),
            SizedBox(height: 10),
            if (novelViewModel.isLoading)
              CircularProgressIndicator(),
            if (novelViewModel.novelId != null)
              Text('소설 ID: ${novelViewModel.novelId}'),
            if (novelViewModel.errorMessage != null)
              Text(
                'Error: ${novelViewModel.errorMessage}',
                style: TextStyle(color: Colors.red),
              ),
            if(novelViewModel.novelImage!=null)
              Text(novelViewModel.novelImage??'이미지가 없습니다'),
          ],
        ),
      ),
    );
  }
}
