class HouseNmaeModel {
  bool? error;
  String? message;
  List<ResultsHouseform>? results;
  String? contentUrl;

  HouseNmaeModel({this.error, this.message, this.results, this.contentUrl});

  HouseNmaeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <ResultsHouseform>[];
      json['results'].forEach((v) {
        results!.add(new ResultsHouseform.fromJson(v));
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

class ResultsHouseform {
  String? sId;
  String? name;
  String? status;
  dynamic totalSpace; // Change the type to int
  dynamic buildingSpace; // Change the type to int
  dynamic apartmentFloorNumber; // Change the type to String

  ResultsHouseform({
    this.sId,
    this.name,
    this.status,
    this.totalSpace,
    this.buildingSpace,
    this.apartmentFloorNumber,
  });

  ResultsHouseform.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    totalSpace = json['total_space']; // Assign correct value
    buildingSpace = json['building_space']; // Assign correct value
    apartmentFloorNumber = json['apartment_floor_number']; // Assign correct value
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['total_space'] = this.totalSpace;
    data['building_space'] = this.buildingSpace;
    data['apartment_floor_number'] = this.apartmentFloorNumber;
    return data;
  }
}
