import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:novel_truck/ui/screens/novel/collection_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novel_truck/ui/screens/record/selectnovel_view.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/app_colors.dart';

class Home extends StatelessWidget {
   Home({super.key});

  @override
  Widget build(BuildContext context) {

    var isrecord=true; /**최근 기록 유무**/

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            child: Column(
              children: [
                   Container(
                     height: 200.h,
                     margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                     child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectNovel()));
                              },
                              child: Container(
                                child: SvgPicture.asset(
                                  'assets/images/RecordButton.svg',
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
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
                                    child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/images/library_icon.svg',
                                              width: 50.w,
                                              height: 50.h,
                                            ),
                                            SizedBox(width: 10.w,),
                                            Text('내 서재',
                                              style: Theme.of(context).textTheme.titleSmall,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                    margin: EdgeInsets.all(5),
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
                                      child: Center(child:
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/images/playlist_icon.svg',
                                              width: 50.w,
                                              height: 50.h,
                                            ),
                                            SizedBox(width: 10.w,),
                                            Text('내 소설 \n플레이리스트',
                                              style: Theme.of(context).textTheme.titleSmall,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )
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
                      height: 150.0.h, // 여유 있게 설정
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
                                    width: 80.w,
                                    height: 100.h,
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
                                        Expanded(
                                          child: Container(
                                              child: Text(
                                                  '텍스트 미리보기 adsf aadfasdfadfsdf \n adfasdadfasdfafafdfasfd \n adfa sdfasdfa',
                                                  style: Theme.of(context).textTheme.displaySmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(double.infinity, 30),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text('이어쓰기',style:TextStyle(fontSize: 14)),
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
                    height: 180.0.h,
                    viewportFraction: 0.3,
                  ),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                                child:Column(
                                  children: [
                                    Container(
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('소설 제목',style: Theme.of(context).textTheme.displaySmall),
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
