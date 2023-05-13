class Question {
  String? id;
  String? title;
  String? category;
  String? mark;

  Question({this.id, this.title, this.category, this.mark});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    title = json['TITLE'];
    category = json['CATEGORY'];
    mark = json['MARK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['TITLE'] = title;
    data['CATEGORY'] = category;
    data['MARK'] = mark;
    return data;
  }
}
