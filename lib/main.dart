import 'package:artacode_test/features/auth/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/presentation/bloc/user_bloc.dart';
import 'features/auth/presentation/bloc/user_event.dart';
import 'features/auth/presentation/bloc/user_state.dart';
import 'features/main/presentation/pages/archive_page.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 225, 232, 234),
      systemNavigationBarColor: Color.fromARGB(255, 225, 232, 234)));
  runApp(
    BlocProvider<AuthBloc>(
      create: (_) => serviceLocator<AuthBloc>(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 703),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocSelector<AuthBloc, AuthState, bool>(
            selector: (AuthState state) {
              return state is AuthLoggedIn;
            },
            builder: (BuildContext context, bool isLoggedIn) {
              if (isLoggedIn) {
                return ArchivePage();
              }
              return MainPage();
            },
          )),
    );
  }
}
