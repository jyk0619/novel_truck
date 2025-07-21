import 'dart:io';

import  'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/novel/collection_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/collectionadd_view.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/screens/novel/collectiondetail_view.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Collection extends StatelessWidget {
  const Collection({super.key});

  @override
  Widget build(BuildContext context) {

    final viewmodel = Provider.of<CollectionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('내 소설\n플레이리스트',style:Theme.of(context).textTheme.titleLarge),
                    Text('내가 좋아하는 소설을 모아둔 곳입니다.',style:Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text('플레이리스트 목록',style:Theme.of(context).textTheme.displayLarge)),
        
              GridView.builder(gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9
                ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                itemCount: viewmodel.collectionList.length + 1, // +1 for "추가" 카드
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // 첫 번째 카드: 컬렉션 추가 버튼
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => AlertDialog(
                            insetPadding: EdgeInsets.all(10),
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            surfaceTintColor: Colors.transparent,
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CollectionAdd(),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Card(
                            child: SizedBox(
                              width: 120.w,
                              height: 120.h,
                                child: Icon(Icons.add, color: AppColors.primary, size: 50)),
                          ),
                          Text('컬렉션 추가', style: Theme.of(context).textTheme.displayMedium),
                        ],
                      ),
                    );
                  } else {
                    final collection = viewmodel.collectionList[index - 1];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CollectionDetail(collectionIndex: index-1),//컬렉션detail에 collection index넘김
                              ),
                            );
                          },
                          child: Card(
                            child: Image.network(
                                (collection.imagePath),
                                fit: BoxFit.cover,
                                width: 120.w,
                                height: 120.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120.w,
                                    height: 120.h,
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.error, color: AppColors.primary, size: 50),
                                  );
                                }
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          collection.title,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
