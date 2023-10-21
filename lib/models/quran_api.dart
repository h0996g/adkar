class QuranApi {
  int? number;
  String? name;
  String? nameSearch;

  // String? englishName;
  // String? englishNameTranslation;
  String? revelationType;
  List<Ayahs> ayahs = [];

  QuranApi.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    nameSearch = json['name2'];
    name = json['name'];
    // englishName = json['englishName'];
    // englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    // if (json['ayahs'] != null) {
    // ayahs = <Ayahs>[];
    json['ayahs'].forEach((element) {
      ayahs.add(Ayahs.fromJson(element));
    });
    // }
  }
}

class Ayahs {
  int? number;
  String? audio;
  // List<String>? audioSecondary;
  String? text;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  var sajda;

  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    audio = json['audio'];
    // audioSecondary = json['audioSecondary'].cast<String>();
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    sajda = json['sajda'];
  }
}
