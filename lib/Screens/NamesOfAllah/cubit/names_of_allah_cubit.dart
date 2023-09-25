import 'dart:convert';

import 'package:adkar/models/names_of_allah.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'names_of_allah_state.dart';

class NamesOfAllahCubit extends Cubit<NamesOfAllahState> {
  NamesOfAllahCubit() : super(NamesOfAllahInitial());
  static NamesOfAllahCubit get(context) => BlocProvider.of(context);
  List<NamesOfAllahModel> namesModel = [];
  Future<void> getNames(context) async {
    DefaultAssetBundle.of(context)
        .loadString('assets/db/Names_Of_Allah/Names_Of_Allah.json')
        .then((value) async {
      namesModel = [];
      var body = jsonDecode(value);
      for (var element in body) {
        namesModel.add(NamesOfAllahModel.fromJson(element));
      }
      // print(namesModel[1].name);
      emit(GetNamesStateGood());
    }).catchError((e) {
      emit(GetNamesStateBad());
    });
  }
}
