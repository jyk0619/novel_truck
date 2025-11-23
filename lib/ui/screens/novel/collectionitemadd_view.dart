import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../novel/novel_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'collection_viewmodel.dart';


class CollectionAddItem extends StatelessWidget {
  final collectionIndex;
   CollectionAddItem({super.key, required this.collectionIndex});//컬렉션 index 받음

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);
    final collectionViewModel = Provider.of<CollectionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('내 소설 목록'),
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
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
           itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage('${novelViewModel.novelList[index].imgPath}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text('${novelViewModel.novelList[index].title}', style: TextStyle(fontSize: 12)),
                      ]),
                ),
                onTap: ( ) {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        surfaceTintColor: Colors.transparent,
                        content: SizedBox(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${novelViewModel.novelList[index].title} 을 ${collectionViewModel.collectionList[collectionIndex].title} 에 추가하시겠어요?', style: TextStyle(fontSize: 14)),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            collectionViewModel.addNovelToCollection(collectionViewModel.collectionList[collectionIndex].id, int.parse(novelViewModel.novelList[index].id));
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            collectionViewModel.initializeCollectionNovels(collectionViewModel.collectionList[collectionIndex].id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('플레이리스트에 소설이 추가되었어요!'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                          child: Text('네'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Theme.of(context).colorScheme.primary,
                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text('아니요'),)
                                      ],
                                    ),
                                  ],
                                )
                            )
                        ),
                      ));
                },
              );
            },
            itemCount: novelViewModel.novelList.length,
        ),
      ),
    );
  }
}

