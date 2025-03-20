import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
                    Text('통합검색',style:Theme.of(context).textTheme.displayLarge),
                    Text('기록과 소설 검색',style:Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    label: '검색어를 입력하세요',
                    controller: TextEditingController(),
                    prefixIcon: Icons.search,
                  )),
            ],
          ),
        ),
      ),
    );
}
}
