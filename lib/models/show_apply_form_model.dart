class ShowApplyFormModel {
  bool? error;
  Results? results;

  ShowApplyFormModel({this.error, this.results});

  ShowApplyFormModel.fromJson(Map<String, dynamic> json) {
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
  String? customerName;
  String? customerPhone;
  String? formId;
  String? houseId;
  String? details;
  String? insertedBy;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? formName;
 // int? formTotalSpace;
  //int? formBuildingSpace;
  String? formBlockNumber;
  String? formStreetNumber;
  String? formCategory;
  String? formCode;
  String? houseName;

  Data(
      {this.sId,
        this.customerName,
        this.customerPhone,
        this.formId,
        this.houseId,
        this.details,
        this.insertedBy,
        this.centerId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.formName,
       // this.formTotalSpace,
      //  this.formBuildingSpace,
        this.formBlockNumber,
        this.formStreetNumber,
        this.formCategory,
        this.formCode,
        this.houseName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    formId = json['form_id'];
    houseId = json['house_id'];
    details = json['details'];
    insertedBy = json['inserted_by'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    formName = json['form_name'];
  //  formTotalSpace = json['form_total_space'];
  //  formBuildingSpace = json['form_building_space'];
    formBlockNumber = json['form_block_number'];
    formStreetNumber = json['form_street_number'];
    formCategory = json['form_category'];
    formCode = json['form_code'];
    houseName = json['house_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['form_id'] = this.formId;
    data['house_id'] = this.houseId;
    data['details'] = this.details;
    data['inserted_by'] = this.insertedBy;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['form_name'] = this.formName;
  //  data['form_total_space'] = this.formTotalSpace;
  //  data['form_building_space'] = this.formBuildingSpace;
    data['form_block_number'] = this.formBlockNumber;
    data['form_street_number'] = this.formStreetNumber;
    data['form_category'] = this.formCategory;
    data['form_code'] = this.formCode;
    data['house_name'] = this.houseName;
    return data;
  }
}


