import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
   Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(child: Text('Card 1')),
                              ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(child: Text('Card 2')),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(child: Text('Card 3')),
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
        
                FlutterCarousel(
                  options: FlutterCarouselOptions(
                    enableInfiniteScroll: true,
                    floatingIndicator: false,
                    showIndicator: false,
                    height: 150.0,
                  ),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                        );
                      },
                    );
                  }).toList(),
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
                            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
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
