import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

lightTheam() => ThemeData(
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.white,
          // shadowColor: Colors.white,
          elevation: 0),
      scaffoldBackgroundColor: Colors.white,
    );
