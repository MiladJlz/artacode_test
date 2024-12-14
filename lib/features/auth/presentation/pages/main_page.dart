import 'package:artacode_test/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_page.dart';

class MainPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const MainPage(),
      );
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: Gradient.lerp(
              RadialGradient(
                colors: [
                  Color.fromARGB(255, 209, 222, 225),
                  Color.fromARGB(255, 225, 232, 234),
                ],
                center: Alignment.topLeft,
                radius: .5,
              ),
              RadialGradient(
                colors: [
                  Color.fromARGB(255, 194, 212, 217),
                  Color.fromARGB(255, 225, 232, 234),
                ],
                center: Alignment.bottomRight,
                radius: .8,
              ),
              1),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Image.asset(
              "assets/MainIMG.png",
              width: 390.w,
              height: 350.h,
            ),
            Image.asset(
              "assets/Logo.png",
              width: 199.w,
              height: 109.h,
            ),
            Text(
              "فروشگاه گیمینو",
              style: TextStyle(
                  fontFamily: "YekanBakh",
                  fontSize: 30.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
            Container(
              width: 256.w,
              child: Text(
                textAlign: TextAlign.center,
                "فروشگاه تخصصی لوازم بازی های رایانه ای و کنسول بازی",
                style: TextStyle(
                  fontFamily: "YekanBakh",
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            SizedBox(
              width: 277.w,
              height: 45.h,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromARGB(255, 1, 131, 255),
                  ),
                  child: Text(
                    "ایجاد حساب کاربری",
                    style: TextStyle(
                        fontFamily: "YekanBakh",
                        letterSpacing: 0,
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
              child: Text(
                "قبلا ثبت نام کرده ام",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontFamily: "YekanBakh",
                    letterSpacing: 0,
                    color: Color.fromARGB(255, 138, 138, 138),
                    fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
