import 'dart:convert';

import 'package:adkar/Screens/quran/cubit/quran_state.dart';
import 'package:adkar/models/quranApi.dart';
import 'package:adkar/models/tafsirModel.dart';
import 'package:adkar/shared/network/dioHalper.dart';

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
      print(dataQuranApi![0].name);
      emit(GetQuranDataStateGood());
    }).catchError((e) {
      print(e.toString());
      emit(GetQuranDataStateGood());
    });
  }

  TafseerModel? tafseerModel;
  Future<void> tafsirAya(
      {int tafseer_id = 1,
      required int sura_number,
      required int ayah_number}) async {
    print(sura_number);
    print(ayah_number);
    await DioHelper.getData(url: '${tafseer_id}/${sura_number}/${ayah_number}')
        .then((value) {
      print(value.data);
      tafseerModel = TafseerModel.fromJson(value.data);

      print(tafseerModel!.text);
      emit(GetTafsirAyaStateGood());
    }).catchError((e) {
      print(e);
      emit(GetTafsirAyaStateGood());
    });
  }
}
