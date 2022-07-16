import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/style_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const id = '/';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 50.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 190.h,
                    width: 190.h,
                    child: Image.asset('assets/images/onboarding.png')),
                Text(
                  '오늘의 모먼트',
                  style: kWhiteBold21,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text('지금 이순간의', style: kGray15),
                SizedBox(
                  height: 10.h,
                ),
                Text('음악과 풍경을 기록해보세요', style: kGray15),
              ],
            )),
            SizedBox(
                height: 54.h,
                width: 335.w,
                child: ElevatedButton(
                    child: const Text('이메일 주소로 로그인'),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                    }, )),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
                height: 54.h,
                width: 335.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('회원가입'),
                        onPressed: () {
                          HapticFeedback.mediumImpact();

                      }, ),
                      Container(
                        width: 2,
                        height: 15,
                        color: kTextButtonColor,
                      ),
                      TextButton(onPressed: () {
                        HapticFeedback.mediumImpact();
                      }, child: const Text('로그인'))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
