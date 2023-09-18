import 'dart:convert';
import 'dart:io';
import 'package:adkar/models/sectionDetailsModel.dart';
import 'package:adkar/models/sectionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

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

// !--------------------------------- Suggest.dart lifl Home-------------------------------
  File? imageCompress;
  Future<void> imagePickerProfile(ImageSource source) async {
    final ImagePicker _pickerProfile = ImagePicker();
    await _pickerProfile.pickImage(source: source).then((value) async {
      await FlutterImageCompress.compressAndGetFile(
        File(value!.path).absolute.path,
        File(value.path).path + '.jpg',
        quality: 10,
      ).then((value) {
        //! test
        imageCompress = File(value!.path);
        emit(ImagePickerSuggestStateGood());
      });
    }).catchError((e) {
      print(e.toString());
      emit(ImagePickerSuggestStateBad());
    });
  }

  void deleteImageSuggest() {
    imageCompress = null;
    emit(DeleteImageSuggestStateGood());
  }

  String? linkSuggestImg;
  Future<void> uploadSuggestImg({required String? text}) async {
    emit(LoadingSeggustUpload());
    if (imageCompress != null)
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Suggests/${Uri.file(imageCompress!.path).pathSegments.last}')
          .putFile(imageCompress!)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) async {
          linkSuggestImg = value;
          print(linkSuggestImg);
          // emit(UploadSeggestImgAndGetUrlStateGood());
        }).catchError((e) {
          emit(UploadSeggestImgAndGetUrlStateBad());
        });
      });
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    await FirebaseFirestore.instance.collection('suggests').doc().set({
      'text': text ?? '',
      'link': linkSuggestImg ?? '',
      "device": androidInfo.model
    }).then((value) {
      emit(UploadSeggestStateGood());
    }).catchError((e) {
      emit(UploadSeggestStateBad());
    });
  }

  void ResetValueSuggest() {
    linkSuggestImg = null;
    imageCompress = null;
    emit(ResetValueSuggestState());
  }
}
