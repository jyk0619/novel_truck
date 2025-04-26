import  'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/screens/novel/collectionitemadd_view.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:provider/provider.dart';

class CollectionDetail extends StatelessWidget {
  final collectionIndex;
   CollectionDetail({super.key, required this.collectionIndex});//컬렉션 index 받음

  @override
  Widget build(BuildContext context) {
  final novelViewModel = Provider.of<NovelViewModel>(context);
    final collection = novelViewModel.collectionList[collectionIndex];


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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Center(child: Text(collection.title,style:Theme.of(context).textTheme.displayLarge)),
                ),

                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 50,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.divider),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: AppColors.primary, size: 30),
                        Text('소설 추가하기',style:Theme.of(context).textTheme.displayMedium),
                      ],
                    ),
                  ),
                  onTap:(){
                    showModalBottomSheet(
                        context: context,
                        builder: (context)=>
                    Container(
                      height: 300,
                      padding: EdgeInsets.all(20),

                      child: Column(
                        children: [
                          Text('소설 추가하기',style:Theme.of(context).textTheme.displayMedium),
                          SizedBox(height: 20),

                          Container(
                            padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.divider),
                              ),
                            child:InkWell(
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.menu_book_outlined, color: AppColors.primary, size: 30),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                        child: Text('내 서재에서 추가하기',style:Theme.of(context).textTheme.displayMedium)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionAddItem(collectionIndex:collectionIndex)));
                              },
                            )
                          )
                        ],
                    ),
                    ));
                  },
                ),

                SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: collection.novels.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,

                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(collection.novels[index].title,style:Theme.of(context).textTheme.displayMedium),
                                  Text(collection.novels[index].author,style:Theme.of(context).textTheme.displaySmall),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
