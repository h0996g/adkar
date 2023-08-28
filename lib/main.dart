import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/Screens/home/home.dart';
import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/shared/blocObserver/observer.dart';
import 'package:adkar/shared/components/helper/cashHelper.dart';
import 'package:adkar/shared/components/helper/constant.dart';
import 'package:adkar/shared/network/dioHalper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  isNotiOn = await CachHelper.getData(key: "isNotiOn") ?? false;
  if (isNotiOn == false) {
    print('awel mra ');

    for (var notif in notifications) {
      await Noti.showTimeNotificationDaily(
          payload: 'adkar',
          id: notif['id'],
          title: 'فَذَكِّرْ',
          body: notif['description']!,
          time: notif['date'],
          fln: Noti.flutterLocalNotificationsPlugin);
    }

    await Noti.showTimeNotificationDaily(
        id: 25,
        payload: 'adkarSabah',
        title: 'اذكار الصباح',
        body: 'اذكار الصباح',
        // scheduleDate: DateTime.now().add(Duration(seconds: 10)),
        time: TimeOfDay(hour: 7, minute: 30),
        fln: Noti.flutterLocalNotificationsPlugin);
    await Noti.showTimeNotificationDaily(
        id: 26,
        payload: 'adkarMasa1',
        title: 'اذكار المساء',
        body: 'اذكار المساء',
        // scheduleDate: DateTime.now().add(Duration(seconds: 10)),
        time: TimeOfDay(hour: 16, minute: 30),
        fln: Noti.flutterLocalNotificationsPlugin);
    await CachHelper.putcache(key: 'isNotiOn', value: true);
  }

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
        ],
        child: MaterialApp(
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      // Status bar color
                      statusBarColor: Colors.black,

                      // Status bar brightness (optional)
                      statusBarIconBrightness:
                          Brightness.light, // For Android (dark icons)
                      statusBarBrightness:
                          Brightness.dark, // For iOS (dark icons)
                    ),
                    iconTheme: IconThemeData(color: Colors.black),
                    color: Colors.white,
                    centerTitle: true),
                scaffoldBackgroundColor: Colors.white),
            title: 'Flutter Demo',
            home: const HomeScreen()));
  }
}
