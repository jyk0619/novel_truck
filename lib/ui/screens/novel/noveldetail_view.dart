import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/novel_model.dart';

class NovelDetail extends StatelessWidget {
  final NovelData novel;
   NovelDetail({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('소설 제목'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset('assets/images/novel1.jpg'),
            SizedBox(height: 10),
            Text(
              '${novel.title}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${novel.author}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
