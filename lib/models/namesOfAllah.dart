class NamesOfAllahModel {
  int? id;
  String? name;
  String? text;

  NamesOfAllahModel({
    this.id,
    this.name,
    this.text,
  });
  NamesOfAllahModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "text": text,
    };
  }
}
