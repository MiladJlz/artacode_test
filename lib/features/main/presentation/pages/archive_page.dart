import 'package:artacode_test/features/auth/presentation/bloc/user_bloc.dart';
import 'package:artacode_test/features/auth/presentation/bloc/user_event.dart';
import 'package:artacode_test/features/auth/presentation/pages/main_page.dart';
import 'package:artacode_test/features/main/presentation/pages/single_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/bloc/user_state.dart';

const items = [
  "Controller.png",
  "Mobile.png",
  "SmartWatch.png",
  "TV.png",
  "Controller.png",
  "SmartWatch.png",
];

class ArchivePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ArchivePage(),
      );
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.pushAndRemoveUntil(
                context, MainPage.route(), (r) => false);
          }
        },
        child: Directionality(
          textDirection: TextDirection.ltr,
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
                  SizedBox(
                    height: 130.h,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 0.h,
                          left: 0,
                          child: Align(
                            child: Transform.translate(
                              offset: Offset(-6.w, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: const Color.fromARGB(
                                        255, 185, 209, 215)),
                                height: 37.h,
                                width: 79.w,
                                margin: EdgeInsets.only(
                                  top: 33.h,
                                ),
                                child: GestureDetector(
                                  onTap: () => context
                                      .read<AuthBloc>()
                                      .add(AuthLogout()),
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
                                              color: Color.fromARGB(
                                                  150, 20, 20, 20)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 30.h,
                            child: Image.asset(
                              height: 120.h,
                              "assets/Logo.png",
                            ))
                      ],
                    ),
                  ),
                  Text(
                    "فروشگاه",
                    style: TextStyle(
                        fontFamily: "YekanBakh",
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: .89,
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SinglePage(
                                      imageName: items[index],
                                    ))),
                        child: ListItem(item: items[index])),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String item;
  const ListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 40.h,
            child: SizedBox(
                width: 150.w,
                height: 130.h,
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(14, 0, 0, 0),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: Offset(0, 4))
                  ]),
                  child: Card(
                    color: const Color.fromARGB(160, 255, 255, 255),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("XBOX  دسته بازی",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "YekanBakh",
                                fontSize: 16.sp,
                                color: Colors.black)),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          "500,000",
                          style: TextStyle(
                              height: .3,
                              fontWeight: FontWeight.w900,
                              fontFamily: "YekanBakh",
                              fontSize: 22.sp,
                              color: const Color.fromARGB(255, 152, 152, 152)),
                        ),
                        Text(
                          "تومان",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "YekanBakh",
                              fontSize: 12.sp,
                              color: const Color.fromARGB(255, 152, 152, 152)),
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    ),
                  ),
                ))),
        Positioned(
          top: 0,
          child: Image.asset(
            "assets/$item",
            width: 120.w,
            height: 95.h,
          ),
        ),
      ],
    );
  }
}
