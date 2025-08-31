import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/novel/noveldetail_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'addnovel_view.dart';

class Novel extends StatelessWidget {
  const Novel({super.key});

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);

    return
      Scaffold(
          appBar: AppBar(
            title: Text('소설 목록'),
            centerTitle: true,
            scrolledUnderElevation: 0,
          ),
          body: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  label: '검색',
                  controller: novelViewModel.searchController,
                  onChanged: (value) {
                    novelViewModel.searchNovel(value);
                  },
                  prefixIcon: Icons.search,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Chip(label: Text('전체'))
                    ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NovelGrid(),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>AddNovel(sharedurl: '',)));//소설 추가 페이지로 이동
            },
            child: Icon(Icons.add),
          )
      );
  }
}

class NovelGrid extends StatelessWidget {
  const NovelGrid({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer<NovelViewModel>(
      builder: (context, novelViewModel, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await novelViewModel.fetchNovelList();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: novelViewModel.isLoading
                ? _buildShimmeringGrid()
                : GridView.builder(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    height: 150.h,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),

                              image: DecorationImage(
                                image: NetworkImage(novelViewModel.novelList[index].imgPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text('${novelViewModel.searchData[index].title}', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovelDetail(
                          novel: novelViewModel.searchData[index],
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: novelViewModel.searchData.length,
            ),
          ),
        );
      },
    );
  }
}


Widget _buildShimmeringGrid() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: Container(
          height: 150.h,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    },
    itemCount: 6, // 예시로 6개의 아이템
  );
}