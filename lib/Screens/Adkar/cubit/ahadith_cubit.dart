import 'dart:convert';
import 'package:adkar/models/sectionDetailsModel.dart';
import 'package:adkar/models/sectionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ahadith_state.dart';

class AhadithCubit extends Cubit<AhadithState> {
  AhadithCubit() : super(AhadithInitial());
  static AhadithCubit get(context) => BlocProvider.of(context);

  List<SectionModel>? dataSections = [];
  List<SectionDetailsModel>? dataAdkarDetails = [];
  List<String> icon = [
    'assets/images/morning.png',
    'assets/images/afternoon.png',
    'assets/images/get-up.png',
    'assets/images/ablution.png',
    'assets/images/sleeping1.png'
  ];

  List<dynamic> colors = [
    Colors.amberAccent,
    Colors.deepOrangeAccent,
    Colors.brown[400],
    Colors.blue,
    Colors.deepPurpleAccent[100]
  ];
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
      dataAdkarDetails = [];
      var body = jsonDecode(value);
      for (var element in body) {
        if (element['section_id'] == id) {
          print(element);
          dataAdkarDetails!.add(SectionDetailsModel.fromJson(element));
        }
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  void readAdkar(int index) {
    print(dataAdkarDetails![index].count);
    if (dataAdkarDetails![index].count! > 1) {
      dataAdkarDetails![index].count = (dataAdkarDetails![index].count!) - 1;
      emit(ReadAdkarStateGood());
      return;
    } else {
      dataAdkarDetails!.removeAt(index);
      emit(ReadAdkarStateGood());
      return;
    }
  }
}
