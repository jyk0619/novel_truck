import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import  'dart:math';
import 'package:go_router/go_router.dart';

import 'package:novel_truck/ui/screens/auth/signupcom_view.dart';

class EzSignUp extends StatefulWidget {
   EzSignUp({super.key});

  @override
  State<EzSignUp> createState() => _EzSignUpState();
}

class _EzSignUpState extends State<EzSignUp> {
   final TextEditingController nameController = TextEditingController();

   Future<void> fetchRandomName() async {
     try {
       final generator = RandomNameGenerator();
       final result = await generator.randomNickName(); // API 요청
       final nickname = result['data']['nickname'].toString(); // 응답에서 닉네임 추출
       setState(() {
         nameController.text = nickname;
       });
     } catch (e) {
       print('랜덤 닉네임 가져오기 실패: $e');
       // 에러 UI나 스낵바도 가능
     }
   }
   randname() {
     Random random = new Random();
     int randomNumber = random.nextInt(100);
     nameController.text = 'user$randomNumber';
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

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
               fetchRandomName();
                },
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                      '/auth/signupcom');
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

class RandomNameGenerator {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  Future<Map<String, dynamic>> randomNickName() async {
    final uri = Uri.parse('$_baseUrl/users/nickname/random');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get nickname: ${response.body}');
    }
  }
}
