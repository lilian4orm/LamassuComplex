class Account {
  String? token;
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? buildingType;
  String? centerId;

  Account(
      {this.token,
      this.sId,
      this.name,
      this.email,
      this.phone,
      this.type,
      this.buildingType,
      this.centerId});

  Account.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    buildingType = json['building_type'];
    centerId = json['center_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['building_type'] = this.buildingType;
    data['center_id'] = this.centerId;
    return data;
  }
}
