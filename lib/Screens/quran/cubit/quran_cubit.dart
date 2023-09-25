import 'dart:convert';

import 'package:adkar/Screens/quran/cubit/quran_state.dart';
import 'package:adkar/models/quran_api.dart';
import 'package:adkar/models/tafsir_model.dart';
import 'package:adkar/shared/network/dio_halper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  static QuranCubit get(context) => BlocProvider.of(context);

  List<QuranApi>? dataQuranApi = [];

  Future<void> getQuranDataApi(BuildContext context) async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/db/quran/quranapi.json')
        .then((value) {
      dataQuranApi = [];
      var body = jsonDecode(value);
      // print(body[0]['name']);
      for (var element in body) {
        dataQuranApi!.add(QuranApi.fromJson(element));
      }
      // print(dataQuranApi![0].name);
      emit(GetQuranDataStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetQuranDataStateGood());
    });
  }

  TafseerModel? tafseerModel;
  Future<void> tafsirAya(
      {int tafseerId = 1,
      required int suraNumber,
      required int ayahNumber}) async {
    // print(suraNumber);
    // print(ayahNumber);
    await DioHelper.getData(url: '$tafseerId/$suraNumber/$ayahNumber')
        .then((value) {
      // print(value.data);
      tafseerModel = TafseerModel.fromJson(value.data);

      // print(tafseerModel!.text);
      emit(GetTafsirAyaStateGood());
    }).catchError((e) {
      print(e);
      emit(GetTafsirAyaStateGood());
    });
  }
}
