class SectionDetailsModel {
  int? sectionId;
  int? count;
  String? description;
  String? reference;
  String? content;
  SectionDetailsModel(
      {this.sectionId,
      this.count,
      this.description,
      this.reference,
      this.content});
  SectionDetailsModel.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    content = json['content'];
  }
  Map<String, dynamic> toMap() {
    return {
      "section_id": sectionId,
      "count": count,
      "description": description,
      "reference": reference,
      "content": content,
    };
  }
}
