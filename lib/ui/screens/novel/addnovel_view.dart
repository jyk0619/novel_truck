import 'package:flutter/material.dart';

class AddNovel extends StatelessWidget {
  const AddNovel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('소설 추가'),
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
            Text('소설 제목', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            Text('소설 제목을 입력하세요', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add your logic to save the novel
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
