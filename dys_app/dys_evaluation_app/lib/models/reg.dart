class Registration {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;

//constructor
  Registration({this.id, this.name, this.email, this.phone, this.password});

  Registration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Registration copy({
    String? password,
    String? name,
    String? phone,
    String? email,
  }) =>
      Registration(
        password: password ?? this.password,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['useremail'] = email;
    data['phone'] = phone;
    data['userpassword'] = password;
    return data;
  }
}
