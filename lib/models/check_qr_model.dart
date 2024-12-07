class CheckQrModel {
  bool? error;
  Results? results;
  String? message;

  CheckQrModel({this.error, this.results, this.message});

  CheckQrModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Results {
  String? sId;
  String? note;
  String? createdAt;
  String? name;
  String? phone;
  String? formName;
  List<int>? formTotalSpace;
  List<double>? formBuildingSpace;
  String? formBlockNumber;
  String? formStreetNumber;
  String? formCode;
  String? houseName;
  String? exactApartmentBuilding;
  String? apartmentFloorNumber;

  Results(
      {this.sId,
      this.note,
      this.createdAt,
      this.name,
      this.phone,
      this.formName,
      this.formTotalSpace,
      this.formBuildingSpace,
      this.formBlockNumber,
      this.formStreetNumber,
      this.formCode,
      this.houseName,
      this.exactApartmentBuilding,
      this.apartmentFloorNumber});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    note = json['note'];
    createdAt = json['createdAt'];
    name = json['name'];
    phone = json['phone'];
    formName = json['form_name'];
    formTotalSpace = json['form_total_space'].cast<int>();
    formBuildingSpace = json['form_building_space'].cast<double>();
    formBlockNumber = json['form_block_number'];
    formStreetNumber = json['form_street_number'];
    formCode = json['form_code'];
    houseName = json['house_name'];
    exactApartmentBuilding = json['exact_apartment_building'];
    apartmentFloorNumber = json['apartment_floor_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['form_name'] = this.formName;
    data['form_total_space'] = this.formTotalSpace;
    data['form_building_space'] = this.formBuildingSpace;
    data['form_block_number'] = this.formBlockNumber;
    data['form_street_number'] = this.formStreetNumber;
    data['form_code'] = this.formCode;
    data['house_name'] = this.houseName;
    data['exact_apartment_building'] = this.exactApartmentBuilding;
    data['apartment_floor_number'] = this.apartmentFloorNumber;
    return data;
  }
}
