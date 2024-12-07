class ServicesModel {
  bool? error;
  String? message;
  List<ServicesResults>? results;
  String? contentUrl;

  ServicesModel({this.error, this.message, this.results, this.contentUrl});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <ServicesResults>[];
      json['results'].forEach((v) {
        results!.add(new ServicesResults.fromJson(v));
      });
    }
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['content_url'] = this.contentUrl;
    return data;
  }
}

class ServicesResults {
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

  ServicesResults(
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

  ServicesResults.fromJson(Map<String, dynamic> json) {
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