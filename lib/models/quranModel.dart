class QuranModel {
  int? id;
  String? name;
  String? type;
  List<QuranAyaDetails> array = [];
  QuranModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    json['array'].forEach((element) {
      array.add(QuranAyaDetails.fromJson(element));
    });
  }
}

class QuranAyaDetails {
  int? id;
  String? ar;

  QuranAyaDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ar = json['ar'];
  }
}
