class MonthlyBillsModel {
  String? sId;
  int? price;
  bool? isPaid;
  String? createdAt;

  MonthlyBillsModel({this.sId, this.price, this.isPaid, this.createdAt});

  MonthlyBillsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    isPaid = json['is_paid'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['price'] = this.price;
    data['is_paid'] = this.isPaid;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
