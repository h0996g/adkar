import 'dart:convert';

import 'package:adkar/Screens/quran/cubit/quran_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/quranModel.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  static QuranCubit get(context) => BlocProvider.of(context);
  List<QuranModel>? dataQuranDetails = [];

  Future<void> getQuranData(BuildContext context) async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/db/quran/Quran.json')
        .then((value) {
      dataQuranDetails = [];
      var body = jsonDecode(value);

      for (var element in body) {
        dataQuranDetails!.add(QuranModel.fromJson(element));
      }
      emit(GetQuranDataStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetQuranDataStateGood());
    });
  }
}
