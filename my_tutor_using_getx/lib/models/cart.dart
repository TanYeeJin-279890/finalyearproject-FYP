class Cart {
  String? cartid;
  String? subname;
  String? subsession;
  String? subprice;
  String? cartqty;
  String? subid;
  String? pricetotal;

  Cart(
      {this.cartid,
      this.subname,
      this.subsession,
      this.subprice,
      this.cartqty,
      this.subid,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cartid'];
    subname = json['subname'];
    subsession = json['subsession'];
    subprice = json['price'];
    cartqty = json['cartqty'];
    subid = json['subid'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartid'] = cartid;
    data['subname'] = subname;
    data['subsession'] = subsession;
    data['subprice'] = subprice;
    data['cartqty'] = cartqty;
    data['subid'] = subid;
    data['pricetotal'] = pricetotal;
    return data;
  }
}
