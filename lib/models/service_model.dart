class ServiceModel {
  String? sId;
  String? name;
  String? centerId;
  String? address;
  String? phone;
  String? serviceId;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Service? service;

  ServiceModel(
      {this.sId,
      this.name,
      this.centerId,
      this.address,
      this.phone,
      this.serviceId,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.service});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    centerId = json['center_id'];
    address = json['address'];
    phone = json['phone'];
    serviceId = json['service_id'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['center_id'] = this.centerId;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['service_id'] = this.serviceId;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  String? sId;
  String? name;
  int? price;
  bool? isDeleted;
  bool? isAvailable;
  String? type;
  String? image;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Service(
      {this.sId,
      this.name,
      this.price,
      this.isDeleted,
      this.isAvailable,
      this.type,
      this.image,
      this.centerId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    isDeleted = json['is_deleted'];
    isAvailable = json['is_available'];
    type = json['type'];
    image = json['image'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['is_deleted'] = this.isDeleted;
    data['is_available'] = this.isAvailable;
    data['type'] = this.type;
    data['image'] = this.image;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
