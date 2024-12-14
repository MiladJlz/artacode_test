import 'package:artacode_test/features/auth/presentation/pages/login_page.dart';
import 'package:artacode_test/features/main/presentation/pages/archive_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/show_snackbar.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccess) {
                Navigator.pushAndRemoveUntil(
                    context, ArchivePage.route(), (r) => false);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Image.asset(
                        "assets/Logo.png",
                        width: 199.w,
                        height: 109.h,
                      ),
                      Image.asset(
                        "assets/LoginIMG.png",
                        width: 312.w,
                        height: 216.h,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.only(right: 64.w),
                          child: Text(
                            "ایمیل",
                            style: TextStyle(
                                fontFamily: "YekanBakh",
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 60.h,
                          width: 277.w,
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255, 1, 131, 255),
                            cursorErrorColor: Color.fromARGB(255, 1, 131, 255),
                            textDirection: TextDirection.ltr,
                            validator: (value) {
                              if (value!.length < 10) {
                                return "ایمیل باید حداقل 10 کاراکتر داشته باشد";
                              }
                              return null;
                            },
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(fontFamily: "YekanBakh"),
                                contentPadding: EdgeInsets.all(15),
                                hintText: "Info@example.com",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 196, 196, 196),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(100.r))),
                          )),
                      SizedBox(
                        height: 14.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.only(right: 64.w),
                          child: Text(
                            "رمز عبور",
                            style: TextStyle(
                                fontFamily: "YekanBakh",
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                          height: 60.h,
                          width: 277.w,
                          child: TextFormField(
                            cursorColor: Color.fromARGB(255, 1, 131, 255),
                            cursorErrorColor: Color.fromARGB(255, 1, 131, 255),
                            textDirection: TextDirection.ltr,
                            validator: (value) {
                              if (value!.length < 5) {
                                return "پسورد باید حداقل 5 کاراکتر داشته باشد";
                              }
                              return null;
                            },
                            controller: passwordController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(fontFamily: "YekanBakh"),
                                hintTextDirection: TextDirection.rtl,
                                contentPadding: EdgeInsets.all(15),
                                hintText: "رمز عبور دلخواه حداقل 5 کاراکتر",
                                hintStyle: TextStyle(
                                    fontFamily: "YekanBakh",
                                    color: Color.fromARGB(255, 196, 196, 196),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(100.r))),
                          )),
                      SizedBox(
                        height: 35.h,
                      ),
                      SizedBox(
                        width: 277.w,
                        height: 45.h,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(AuthSignUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 131, 255),
                            ),
                            child: BlocSelector<AuthBloc, AuthState, bool>(
                              selector: (AuthState state) {
                                return state is AuthLoading;
                              },
                              builder: (context, state) {
                                if (state) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ));
                                } else {
                                  return Text(
                                    "ثبت نام",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0,
                                        fontFamily: "YekanBakh",
                                        color: Colors.white,
                                        fontSize: 20.sp),
                                  );
                                }
                              },
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
            },
          ),
        ),
      ),
    );
  }
}
