import  'package:flutter/material.dart';

class AddRecord extends StatelessWidget {
  const AddRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text('기록 추가', style: Theme.of(context).textTheme.titleMedium),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                showDialog(context: context,
                  barrierDismissible: true,
                  builder: (context) => AlertDialog(
                    insetPadding: EdgeInsets.all(10),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    surfaceTintColor: Colors.transparent,
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text('내 서재'),
                    ),
                  ),
                );
              },

                  child: Text('내 서재로 가기'),
              ),
              SizedBox(height: 10),
              Text('내 서재에서 소설을 선택해주세요', style: Theme.of(context).textTheme.displaySmall),
              // Add your form fields here
            ],
          ),
        ),
    );
  }
}
