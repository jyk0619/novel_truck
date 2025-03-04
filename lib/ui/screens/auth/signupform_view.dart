import 'package:flutter/material.dart';
import 'package:novel_truck/ui/components/textfields/custom_textfield.dart';
import 'package:novel_truck/ui/screens/auth/signupform_viewmodel.dart';
import 'package:provider/provider.dart';


class SignUpForm extends StatelessWidget {
   SignUpForm({super.key});
  final TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
  final viewModel = Provider.of<SignUpFormViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('가입 하기'),

      ),
      body: SingleChildScrollView(
        child: Center(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:[
                CustomTextField(label: "Email", controller: viewModel.emailController, prefixIcon: Icons.email_outlined),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(label: "ID", controller: viewModel.idController, prefixIcon: Icons.person_outline)),
                    ElevatedButton(onPressed: (){}, child: Text("중복확인")),
                  ],
                ),
                SizedBox(height: 10),
                CustomTextField(label: "Password", controller: viewModel.passwordController, obscureText: true, prefixIcon: Icons.lock_outline),
                SizedBox(height: 10),
                CustomTextField(label: "Password Confirm", controller: viewModel.passwordConfirmController, obscureText: true, prefixIcon: Icons.lock_outline
                ,onEditingComplete: ()=>viewModel.checkPasswordMatch(),),
                if(viewModel.isChecked)
                  Text(
                  viewModel.isPasswordMatched ? "비밀번호 일치" : "비밀번호가 일치하지 않습니다.",
                  style: TextStyle(
                    color: viewModel.isPasswordMatched ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(label: "이름(닉네임)", controller: viewModel.nameController, prefixIcon: Icons.person_outline),
                ElevatedButton(
                  onPressed: () {
                    //기능추가
                  },
                  child: const Text('가입하기'),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }
}
