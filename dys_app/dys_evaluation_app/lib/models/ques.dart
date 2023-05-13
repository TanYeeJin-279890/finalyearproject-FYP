class Question {
  String? id;
  String? section;
  String? title;
  String? category;
  String? mark;

  Question({this.id, this.section, this.title, this.category, this.mark});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    section = json['SECTION'];
    title = json['TITLE'];
    category = json['CATEGORY'];
    mark = json['MARK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['SECTION'] = section;
    data['TITLE'] = title;
    data['CATEGORY'] = category;
    data['MARK'] = mark;
    return data;
  }
}
