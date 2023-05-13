class Evaluatee {
  String? user_id;
  String? evaluatee_id;
  String? evaluatee_name;
  String? age;
  String? Verbal_marks;
  String? Social_marks;
  String? Narrative_marks;
  String? Spatial_marks;
  String? Kinesthetic_marks;
  String? Visual_marks;
  String? MathSci_marks;
  String? Musical_marks;

  Evaluatee(
      {this.user_id,
      this.evaluatee_id,
      this.evaluatee_name,
      this.age,
      this.Verbal_marks,
      this.Social_marks,
      this.Narrative_marks,
      this.Spatial_marks,
      this.Kinesthetic_marks,
      this.Visual_marks,
      this.MathSci_marks,
      this.Musical_marks});

  Evaluatee.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    evaluatee_id = json['evaluatee_id'];
    evaluatee_name = json['evaluatee_name'];
    age = json['age'];
    Verbal_marks = json['Verbal_marks'];
    Social_marks = json['Social_marks'];
    Narrative_marks = json['Narrative_marks'];
    Spatial_marks = json['Spatial_marks'];
    Kinesthetic_marks = json['Kinesthetic_marks'];
    Visual_marks = json['Visual_marks'];
    MathSci_marks = json['MathSci_marks'];
    Musical_marks = json['Musical_marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_id'] = user_id;
    data['evaluatee_id'] = evaluatee_id;
    data['evaluatee_name'] = evaluatee_name;
    data['age'] = age;
    data['Verbal_marks'] = Verbal_marks;
    data['Social_marks'] = Social_marks;
    data['Narrative_marks'] = Narrative_marks;
    data['Spatial_marks'] = Spatial_marks;
    data['Kinesthetic_marks'] = Kinesthetic_marks;
    data['Visual_marks'] = Visual_marks;
    data['MathSci_marks'] = MathSci_marks;
    data['Musical_marks'] = Musical_marks;
    return data;
  }
}
