import 'package:flutter/material.dart';

class SignUpFormViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool _isPasswordMatched = true;
  bool _isChecked = false; // 확인 버튼을 눌렀는지 여부

  bool get isPasswordMatched => _isPasswordMatched;
  bool get isChecked => _isChecked;

  void checkPasswordMatch() {
    _isChecked = true;
    _isPasswordMatched = passwordController.text == passwordConfirmController.text;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    idController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
