import  'package:flutter/material.dart';
import 'package:novel_truck/ui/screens/novel/collectionadd_view.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/screens/novel/collectiondetail_view.dart';

class Collection extends StatelessWidget {
  const Collection({super.key});

  @override
  Widget build(BuildContext context) {
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
        
              GridView(gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                      child: Card(
                          child: Icon(Icons.add, color: AppColors.primary, size: 50),
                      ),
                      onTap: () {
                        showDialog(context: context,
                          barrierDismissible: true,
                          builder: (context) => AlertDialog(
                            insetPadding: EdgeInsets.all(10),
                            backgroundColor: AppColors.background,
                            surfaceTintColor: Colors.transparent,
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                                child: CollectionAdd()),
                          ),
                        );
                      }
                    ),
                    InkWell(
                        child: Card(
                            child:
                        Text('소설')
                        ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionDetail()));
                            }
                    ),
                    Card(child: Text('소설')),
                    Card(child: Text('소설')),
                    Card(child: Text('소설')),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
