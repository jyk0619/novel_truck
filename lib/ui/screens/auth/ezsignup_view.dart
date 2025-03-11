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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Text('거의 다 왔어요!', style: Theme.of(context).textTheme.titleLarge)),
                SizedBox(
                    width: double.infinity,
                    child: Text('프로필을 등록해주세요.', style: Theme.of(context).textTheme.titleLarge)),

                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: Text('프로필 사진', style: Theme.of(context).textTheme.displayLarge)),
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    color: AppColors.primary,
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(label:'닉네임', controller: nameController, prefixIcon: Icons.person),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: (){
                  randname();
                }, child: const Text('닉네임 자동 생성')),
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
        ),
      ));
  }
}
