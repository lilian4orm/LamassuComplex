


class FormNameModel {
  bool? error;
  String? message;
  List<ResultsFormName>? results;
  String? contentUrl;

  FormNameModel({this.error, this.message, this.results, this.contentUrl});

  FormNameModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <ResultsFormName>[];
      json['results'].forEach((v) {
        results!.add(new ResultsFormName.fromJson(v));
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

class ResultsFormName {
  String? sId;
  String? buildingType;
  String? name;
  List<String>? images;
  List<dynamic>? totalSpace;
  List<dynamic>? buildingSpace;
  String? blockNumber;
  List<dynamic>? apartmentBuilding;
  String? category;
  String? streetNumber;
  List<dynamic>? apartmentFloors;

  ResultsFormName(
      {this.sId,
        this.buildingType,
        this.name,
        this.images,
        this.totalSpace,
        this.buildingSpace,
        this.blockNumber,
        this.apartmentBuilding,
        this.category,
        this.streetNumber,
        this.apartmentFloors});

  ResultsFormName.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buildingType = json['building_type'];
    name = json['name'];
    images = json['images'].cast<String>();
    totalSpace = json['total_space'].cast<dynamic>();
    buildingSpace = json['building_space'].cast<dynamic>();
    blockNumber = json['block_number'];
    apartmentBuilding = json['apartment_building'].cast<dynamic>();
    category = json['category'];
    streetNumber = json['street_number'];
    apartmentFloors = json['apartment_floors'].cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['building_type'] = this.buildingType;
    data['name'] = this.name;
    data['images'] = this.images;
    data['total_space'] = this.totalSpace;
    data['building_space'] = this.buildingSpace;
    data['block_number'] = this.blockNumber;
    data['apartment_building'] = this.apartmentBuilding;
    data['category'] = this.category;
    data['street_number'] = this.streetNumber;
    data['apartment_floors'] = this.apartmentFloors;
    return data;
  }
}

