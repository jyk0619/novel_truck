import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:novel_truck/ui/screens/novel/collection_view.dart';
class Home extends StatelessWidget {
   Home({super.key});

  @override
  Widget build(BuildContext context) {

    var isrecord=false; /**최근 기록 유무**/

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            child: Column(
              children: [
                   Container(
                     height: 200,
                     margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                     child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Center(child: Text('기록하기')),
                              ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Center(child: Text('내 서재')),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                    margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Center(child: Text('내 소설 \n플레이리스트')
                                      ),
                                    ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Collection()));
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                     ),
                   ),
                Container(
                  width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('최근기록',style: Theme.of(context).textTheme.displayLarge,)),

                isrecord
                    ?SizedBox(
                  child: FlutterCarousel(
                    options: FlutterCarouselOptions(
                      enableInfiniteScroll: true,
                      floatingIndicator: false,
                      showIndicator: false,
                      height: 150.0, // 여유 있게 설정
                      viewportFraction: 0.85,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10), // 하단 잘림 방지
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text('소설 제목', style: Theme.of(context).textTheme.titleMedium),
                                        Text('텍스트 미리보기', style: Theme.of(context).textTheme.displaySmall),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text('이어쓰기'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
                :Container(
                  padding: const EdgeInsets.all(10),
                    height: 150,
                width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Expanded(child: Container(child: Text('아직 등록된\n소설이 없네요. '
                              '\n기록하고 싶은 소설이\n있나요?',style: Theme.of(context).textTheme.displayMedium))),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.black, size: 30),
                                  ElevatedButton(onPressed: (){}, child:
                                    Text('소설 기록하기')
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      )
                ),

                Container(
                  width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('읽고있는 소설',style: Theme.of(context).textTheme.displayLarge,)),

                FlutterCarousel(
                  options: FlutterCarouselOptions(
                    enableInfiniteScroll: true,
                    floatingIndicator: false,
                    showIndicator: false,
                    disableCenter: false,
                    pageSnapping: true,
                    height: 150.0,
                    viewportFraction: 0.3,
                  ),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                                child:Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ))
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
        
            ),
          ),
        ),
      ),);
  }
}
