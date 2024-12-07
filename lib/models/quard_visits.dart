class GuardVisits {
  bool? error;
  Results? results;

  GuardVisits({this.error, this.results});

  GuardVisits.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  List<Data>? data;
  int? count;

  Results({this.data, this.count});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Data {
  String? sId;
  String? qrCodeId;
  bool? isDeleted;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? ownerName;
  String? ownerPhone;

  Data(
      {this.sId,
        this.qrCodeId,
        this.isDeleted,
        this.centerId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.ownerName,
        this.ownerPhone});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    qrCodeId = json['qr_code_id'];
    isDeleted = json['is_deleted'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    ownerName = json['owner_name'];
    ownerPhone = json['owner_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['qr_code_id'] = this.qrCodeId;
    data['is_deleted'] = this.isDeleted;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['owner_name'] = this.ownerName;
    data['owner_phone'] = this.ownerPhone;
    return data;
  }
}