import 'package:adkar/Screens/Adkar/cubit/ahadith_cubit.dart';
import 'package:adkar/Screens/home/home.dart';
import 'package:adkar/Screens/quran/cubit/quran_cubit.dart';
import 'package:adkar/shared/blocObserver/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
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
            create: ((context) => QuranCubit()..getQuranData(context)),
            lazy: false,
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(
                appBarTheme:
                    const AppBarTheme(color: Colors.green, centerTitle: true),
                scaffoldBackgroundColor: Colors.white),
            title: 'Flutter Demo',
            home: const HomeScreen()));
  }
}
