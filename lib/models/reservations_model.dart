class ReservationsModel {
  ResultsReservations? results;
  String? message;
  bool? error;

  ReservationsModel({this.results, this.message, this.error});

  ReservationsModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? new ResultsReservations.fromJson(json['results']) : null;
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class ResultsReservations {
  String? name;
  String? centerId;
  String? address;
  String? phone;
  bool? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ResultsReservations(
      {this.name,
        this.centerId,
        this.address,
        this.phone,
        this.isDeleted,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ResultsReservations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    centerId = json['center_id'];
    address = json['address'];
    phone = json['phone'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['center_id'] = this.centerId;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['is_deleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}