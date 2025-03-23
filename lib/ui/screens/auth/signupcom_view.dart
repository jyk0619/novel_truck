import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import '../home/homenav_view.dart';

class SignUpCom extends StatelessWidget {
  const SignUpCom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('간편 회원가입', style: Theme.of(context).textTheme.displaySmall),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 3,
                        margin: const EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 3,
                        margin: const EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 3,
                        margin: const EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(
              '회원가입이 완료되었습니다.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeNav()),
                      (route) => false);
                },
                child: const Text('시작하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
