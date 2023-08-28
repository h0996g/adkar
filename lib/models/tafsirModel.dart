class TafseerModel {
  int? tafseer_id;
  String? tafseer_name;
  String? ayah_url;
  int? ayah_number;
  String? text;
  TafseerModel.fromJson(Map<String, dynamic> json) {
    tafseer_id = json['tafseer_id'];
    tafseer_name = json['tafseer_name'];
    ayah_url = json['ayah_url'];
    ayah_number = json['ayah_number'];
    text = json['text'];
  }
}
