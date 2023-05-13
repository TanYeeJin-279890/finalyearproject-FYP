class Registration {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? datereg;
  String? cart;

  Registration(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.datereg,
      this.cart});

  Registration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    datereg = json['datereg'];
    cart = json['cart'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    data['datereg'] = datereg;
    data['cart'] = cart.toString();
    return data;
  }
}
