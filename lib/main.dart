import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/Screens/NamesOfAllah/cubit/names_of_allah_cubit.dart';
import 'package:adkar/Screens/home/home.dart';
import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/shared/blocObserver/observer.dart';
import 'package:adkar/shared/components/functions.dart';
import 'package:adkar/shared/helper/cash_helper.dart';
import 'package:adkar/shared/helper/constant.dart';
import 'package:adkar/shared/network/dio_halper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import 'Screens/settings/cubit/settings_cubit.dart';
import 'firebase_options.dart';
import 'notification.dart';

main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  Noti.init();
  await cacheHelperRecoveryValue();
  await firstTimeNoti(isFirstTime: isFirstTimeAppCH);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AhadithCubit()..getSectionDb(context)),
        ),
        BlocProvider(
          create: ((context) => QuranCubit()..getQuranDataApi(context)),
          lazy: false,
        ),
        BlocProvider(
          create: ((context) => NamesOfAllahCubit()..getNames(context)),
        ),
        BlocProvider(
          create: ((context) => SettingsCubit()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(
                headlineSmall: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade400,
                ),
                displayMedium: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700)),
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(color: Colors.black),
                color: Colors.white,
                titleTextStyle: TextStyle(fontSize: 30, color: Colors.black),
                centerTitle: true),
            scaffoldBackgroundColor: Colors.white),
        title: 'Flutter Demo',
        home: ShowCaseWidget(
            onStart: (index, key) async {
              if (index == 1) {
                await Scrollable.ensureVisible(
                  key.currentContext!,
                  alignment: -1,
                );
              }
            },
            onComplete: (index, key) async {},
            onFinish: () async {
              print('test finich');
              await CachHelper.putcache(key: 'isFirstTimeAdkar', value: false)
                  .then((value) {
                isFirstTimeAdkarCH = false;
              });
            },
            builder: Builder(
              builder: (context) => const HomeScreen(),
            )),
      ),
    );
  }
}
