import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/bloc/user_bloc.dart';
import '../../../auth/presentation/bloc/user_event.dart';
import '../../../auth/presentation/bloc/user_state.dart';
import '../../../auth/presentation/pages/main_page.dart';

const itemColors = [
  Colors.black,
  Color.fromARGB(255, 255, 215, 7),
  Color.fromARGB(255, 1, 131, 255),
  Colors.white
];

class SinglePage extends StatefulWidget {
  final String imageName;
  const SinglePage({super.key, required this.imageName});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  int selectedIndex = 0;
  int counter = 0;
  double _opacity = 1;
  void _onCircleTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = [widget.imageName, widget.imageName, widget.imageName];
    String? swipeDirection;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.pushAndRemoveUntil(
                context, MainPage.route(), (r) => false);
          }
        },
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
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Transform.translate(
                  offset: Offset(-6.w, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color.fromARGB(255, 185, 209, 215)),
                    height: 37.h,
                    width: 79.w,
                    margin: EdgeInsets.only(
                      top: 33.h,
                    ),
                    child: GestureDetector(
                      onTap: () => context.read<AuthBloc>().add(AuthLogout()),
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/solar_logout-2-outline.png",
                              width: 19.w,
                              height: 23.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'خروج',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "YekanBakh",
                                  fontSize: 15.sp,
                                  color: Color.fromARGB(150, 20, 20, 20)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 220.w),
                width: 95.w,
                height: 30.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0,
                          color: Color.fromARGB(150, 1, 131, 255))
                    ],
                    color: const Color.fromARGB(255, 1, 131, 255),
                    borderRadius: BorderRadius.circular(100.r)),
                child: Center(
                  child: Text(
                    "دسته بازی",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "YekanBakh",
                        fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "XBOX   دسته بازی مخصوص",
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.black,
                  fontFamily: "YekanBakh",
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(0, -16),
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: 177.w,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          "500,000",
                          style: TextStyle(
                              fontFamily: "YekanBakh",
                              fontWeight: FontWeight.w900,
                              fontSize: 35.sp,
                              color: const Color.fromARGB(255, 152, 152, 152)),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "تومان",
                          style: TextStyle(
                              fontFamily: "YekanBakh",
                              fontWeight: FontWeight.w900,
                              fontSize: 16.sp,
                              color: const Color.fromARGB(255, 152, 152, 152)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 220.h,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 400.w,
                      height: 400.h,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Transform.translate(
                            offset: Offset(130.w, -35.h),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                  width: 400,
                                  height: 400,
                                  child: GestureDetector(
                                    onPanUpdate: (details) {
                                      swipeDirection =
                                          details.delta.dy < 0 ? 'up' : 'down';
                                    },
                                    onPanEnd: (details) {
                                      if (swipeDirection == null) {
                                        return;
                                      }
                                      if (swipeDirection == 'up') {
                                        if (counter < 2) {
                                          setState(() => _opacity = 0);
                                          Future.delayed(
                                              Duration(milliseconds: 500),
                                              () => setState(() {
                                                    counter = (counter + 1)
                                                        .clamp(0, 2);
                                                    _opacity = 1;
                                                  }));
                                        }
                                      }
                                      if (swipeDirection == 'down') {
                                        if (counter > 0) {
                                          setState(() => _opacity = 0);
                                          Future.delayed(
                                              Duration(milliseconds: 500),
                                              () => setState(() {
                                                    counter = (counter - 1)
                                                        .clamp(0, 2);

                                                    _opacity = 1;
                                                  }));
                                        }
                                      }
                                    },
                                    child: AnimatedOpacity(
                                      opacity: _opacity,
                                      duration: Duration(milliseconds: 500),
                                      child: Image.asset(
                                        key: ValueKey<int>(counter),
                                        "assets/${imageUrls[counter]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                            )),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      left: 32.w,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (counter > 0) {
                                setState(() => _opacity = 0);
                                Future.delayed(
                                    Duration(milliseconds: 500),
                                    () => setState(() {
                                          counter = (counter - 1).clamp(0, 2);

                                          _opacity = 1;
                                        }));
                              }
                            },
                            child: Image.asset(
                              "assets/bxs_up-arrow-alt.png",
                              width: 23.w,
                              height: 23.h,
                            ),
                          ),
                          DotsIndicator(
                            axis: Axis.vertical,
                            dotsCount: imageUrls.length,
                            position: counter,
                            decorator: DotsDecorator(
                              activeColor: Color.fromARGB(90, 1, 131, 255),
                              color: Colors.white,
                              size: Size.square(9.w),
                              activeSize: Size(10.0.w, 10.0.h),
                              activeShape: CircleBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Transform.flip(
                            flipY: true,
                            child: GestureDetector(
                              onTap: () {
                                if (counter < 2) {
                                  setState(() => _opacity = 0);
                                  Future.delayed(
                                      Duration(milliseconds: 500),
                                      () => setState(() {
                                            counter = (counter + 1).clamp(0, 2);
                                            _opacity = 1;
                                          }));
                                }
                              },
                              child: Image.asset(
                                "assets/bxs_up-arrow-alt.png",
                                width: 23.w,
                                height: 23.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 279.w),
                  child: Text(
                    "توضیحات",
                    style: TextStyle(
                        fontFamily: "YekanBakh",
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: Colors.black),
                  ),
                ),
              ),
              RichText(
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "لورم ایپسوم متن"
                            " ساختگی با تولید سادگی نامفهوم"
                            "\n",
                        style: TextStyle(
                          fontFamily: "YekanBakh",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(.75),
                        )),
                    TextSpan(
                        text: "از صنعت چاپ، و با استفاده از طراحان گرافیک است،"
                            ""
                            "\n",
                        style: TextStyle(
                          fontFamily: "YekanBakh",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(.5),
                        )),
                    TextSpan(
                        text: "چاپگرها و متون",
                        style: TextStyle(
                          fontFamily: "YekanBakh",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black.withOpacity(.25),
                        ))
                  ])),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 50.w),
                  child: Text(
                    "+بیشتر",
                    style: TextStyle(
                      fontFamily: "YekanBakh",
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: const Color.fromARGB(255, 1, 131, 255),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 220,
                        height: 50,
                        child: Row(
                            children: List.generate(4, (index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _onCircleTap(index);
                                });
                              },
                              child: SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: index == selectedIndex
                                          ? 40.0.w
                                          : 30.w,
                                      height: index == selectedIndex
                                          ? 40.0.h
                                          : 30.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        color: itemColors[index],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }))),
                    Text(
                      "انتخاب رنگ",
                      style: TextStyle(
                          fontFamily: "YekanBakh",
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                width: 300.w,
                height: 47.h,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color.fromARGB(255, 1, 131, 255),
                    ),
                    child: Text(
                      "افزودن به سبد خرید",
                      style: TextStyle(
                          letterSpacing: 0,
                          fontFamily: "YekanBakh",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20.sp),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
