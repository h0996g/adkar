import 'dart:convert';

import 'package:adkar/models/sectionDetails.dart';
import 'package:adkar/models/sectionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ahadith_state.dart';

class AhadithCubit extends Cubit<AhadithState> {
  AhadithCubit() : super(AhadithInitial());
  static AhadithCubit get(context) => BlocProvider.of(context);
  List<SectionModel>? dataSections = [];
  List<SectionDetails>? dataDetails = [];

  Future<void> getSectionDb(context) async {
    DefaultAssetBundle.of(context)
        .loadString('assets/db/section.json')
        .then((value) async {
      dataSections = [];
      var body = jsonDecode(value);
      for (var element in body) {
        dataSections!.add(SectionModel.fromJson(element));
      }
      emit(GetSectionStateGood());
    }).catchError((e) {
      emit(GetSectionStateBad());
    });
  }

  Future<void> getSectionDetails(BuildContext context, int? id) async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/db/sectionDetails.json')
        .then((value) {
      dataDetails = [];
      var body = jsonDecode(value);
      for (var element in body) {
        if (element['section_id'] == id) {
          print(element);
          dataDetails!.add(SectionDetails.fromJson(element));
        }
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  void readAdkar(int index) {
    print(dataDetails![index].count);
    if (dataDetails![index].count! > 1) {
      dataDetails![index].count = (dataDetails![index].count!) - 1;
      emit(ReadAdkarStateGood());
      return;
    } else {
      dataDetails!.removeAt(index);
      emit(ReadAdkarStateGood());
      return;
    }
  }
}
