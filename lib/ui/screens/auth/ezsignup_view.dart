import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import  'dart:math';

import 'package:novel_truck/ui/screens/auth/signupcom_view.dart';

class EzSignUp extends StatelessWidget {
   EzSignUp({super.key});
   final TextEditingController nameController = TextEditingController();

   randname() {
     Random random = new Random();
     int randomNumber = random.nextInt(100);
     nameController.text = 'user$randomNumber';
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('간편회원가입'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  child: Text('닉네임을\n정해주세요.', style: Theme.of(context).textTheme.titleLarge)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child:Text('닉네임은 환생트럭에서 랜덤으로 제안해드려요!\n'
                    '마음에 들지 않을시 변경탭을 누르시거나\n'
                    '직접입력해주세요!',style: Theme.of(context).textTheme.displaySmall),
              ),
              const SizedBox(height: 20),
              CustomTextField(label:'닉네임', controller: nameController, prefixIcon: Icons.person,
                suffixIcon: Icons.question_mark,
              onSuffixTap: (){
                randname();
                },
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpCom()),
                    );
                  },
                  child: const Text('다음으로'),
                ),
              ),
            ],
          ),
        ),
      ));
  }
}
