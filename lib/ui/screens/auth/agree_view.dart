import 'package:flutter/material.dart';
import 'package:novel_truck/core/theme/app_colors.dart';
import 'package:novel_truck/ui/screens/auth/ezsignup_view.dart';
import 'package:go_router/go_router.dart';

class Agree extends StatefulWidget {
   Agree({super.key});

  @override
  State<Agree> createState() => _AgreeState();
}
bool _isCheckAll = false;
bool _isCheck1 = false;
bool _isCheck2 = false;
bool _isCheck3 = false;

List<String> checkList=[
  '약관 전체동의',
  '개인정보 처리방침 동의',
  '약관',
  '약관'
];

setCheckAll() {
  if (_isCheck1 && _isCheck2 && _isCheck3) {
    _isCheckAll = true;
  }
  else {
    _isCheckAll = false;
  }
}

class _AgreeState extends State<Agree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  Text('간편회원 가입', style: Theme.of(context).textTheme.displaySmall),
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
                          color: AppColors.surface,
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
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: Text('회원가입을 위해\n'
                  '아래 약관에 동의해주세요.', style: Theme.of(context).textTheme.titleLarge)),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _isCheckAll,
                    onChanged: (value) {
                      setState(() {
                        _isCheckAll = value!;
                        _isCheck1 = value;
                        _isCheck2 = value;
                        _isCheck3 = value;

                        setCheckAll();
                      });
                    },
                  ),
                  Text('약관 전체동의', style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
            ),

            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child:Row(
                  children: [
                    Checkbox(
                      value: _isCheck1,
                      onChanged: (value) {
                        setState(() {
                          _isCheck1 = value!;
                          setCheckAll();
                        });
                      },
                    ),
                    Text('개인정보 처리방침 동의', style: Theme.of(context).textTheme.displaySmall),
                    Icon(Icons.arrow_forward_ios, size: 15,)
                  ],
                )
            ),

            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child:Row(
                  children: [
                    Checkbox(
                      value: _isCheck2,
                      onChanged: (value) {
                        setState(() {
                          _isCheck2 = value!;
                          setCheckAll();
                        });
                      },
                    ),
                    Text('약관', style: Theme.of(context).textTheme.displaySmall),
                    Icon(Icons.arrow_forward_ios, size: 15,)
                  ],
                )
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child:Row(
                  children: [
                    Checkbox(
                      value: _isCheck3,
                      onChanged: (value) {
                        setState(() {
                          _isCheck3 = value!;
                          setCheckAll();
                        });
                      },
                    ),
                    Text('약관', style: Theme.of(context).textTheme.displaySmall),
                    Icon(Icons.arrow_forward_ios, size: 15,)
                  ],
                )
            ),
            SizedBox(height: 20,),

            _isCheckAll
                ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  context.push(
                    '/auth/signup',
                  );
                },
                child: Text('다음으로'),
              ),
            )
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                onPressed: null,
                child: Text('다음으로'),
              ),
            )
           ],
        ),
      ),
    );
  }
}
