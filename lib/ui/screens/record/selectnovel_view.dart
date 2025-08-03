import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/novel/novel_viewmodel.dart';
import 'package:novel_truck/ui/screens/record/newrecord_view.dart';
import 'package:provider/provider.dart';


class SelectNovel extends StatelessWidget {
  const SelectNovel({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(
         title: Text('소설 선택'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:NovelGrid(),
          ),
    );
  }
}

class NovelGrid extends StatefulWidget {
  const NovelGrid({super.key});

  @override
  State<NovelGrid> createState() => _NovelGridState();
}

class _NovelGridState extends State<NovelGrid> {

  @override
  void dispose() {
    final novelViewModel = Provider.of<NovelViewModel>(context);
    novelViewModel.clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final novelViewModel = Provider.of<NovelViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            CustomTextField(
              label: '검색',
              controller: novelViewModel.searchController,
              onChanged: (value) {
                novelViewModel.searchNovel(value);
              },
              prefixIcon: Icons.search,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(novelViewModel.searchData[index].imgPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text('${novelViewModel.searchData[index].title}',
                                style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis),
                          ]),
                    ),
                    onTap: ( ) {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Text('소설 선택'),
                          content: Text('소설을 선택하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                // 소설 선택 로직
                                Navigator.pop(context);
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NewRecord(
                                  novel: novelViewModel.searchData[index],
                                )
                                ),
                                );
                              },
                              child: Text('확인'),
                            ),
                          ],
                        );
                      });
                    },
                  );
                },
                itemCount: novelViewModel.searchData.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
