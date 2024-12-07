class centerForms {
  bool? error;
  String? message;
  List<Results>? results;
  String? contentUrl;

  centerForms({this.error, this.message, this.results, this.contentUrl});

  centerForms.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
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

class Results {
  String? sId;
  String? buildingType;
  String? name;
  List<String>? apartmentFloors;
  String? formCode;
  List<String>? images;
  List<double>? totalSpace;
  List<double>? buildingSpace;
  String? streetNumber;
  String? category;
  List<String>? apartmentBuilding;
  String? blockNumber;
  String? centerId;
  List<Houses>? houses;
  String? createdAt;

  Results(
      {this.sId,
        this.buildingType,
        this.name,
        this.apartmentFloors,
        this.formCode,
        this.images,
        this.totalSpace,
        this.buildingSpace,
        this.streetNumber,
        this.category,
        this.apartmentBuilding,
        this.blockNumber,
        this.centerId,
        this.houses,
        this.createdAt});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buildingType = json['building_type'];
    name = json['name'];
    apartmentFloors = json['apartment_floors'].cast<String>();
    formCode = json['form_code'];
    images = json['images'].cast<String>();
    totalSpace = json['total_space'].cast<double>();
    buildingSpace = json['building_space'].cast<double>();
    streetNumber = json['street_number'];
    category = json['category'];
    apartmentBuilding = json['apartment_building'].cast<String>();
    blockNumber = json['block_number'];
    centerId = json['center_id'];
    if (json['houses'] != null) {
      houses = <Houses>[];
      json['houses'].forEach((v) {
        houses!.add(new Houses.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['building_type'] = this.buildingType;
    data['name'] = this.name;
    data['apartment_floors'] = this.apartmentFloors;
    data['form_code'] = this.formCode;
    data['images'] = this.images;
    data['total_space'] = this.totalSpace;
    data['building_space'] = this.buildingSpace;
    data['street_number'] = this.streetNumber;
    data['category'] = this.category;
    data['apartment_building'] = this.apartmentBuilding;
    data['block_number'] = this.blockNumber;
    data['center_id'] = this.centerId;
    if (this.houses != null) {
      data['houses'] = this.houses!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Houses {
  String? name;
  double? totalSpace;
  double? buildingSpace;
  var apartmentFloorNumber;
  String? status;
  String? sId;
  List<Rooms>? rooms;

  Houses(
      {this.name,
        this.totalSpace,
        this.buildingSpace,
        this.apartmentFloorNumber,
        this.status,
        this.sId,
        this.rooms});

  Houses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSpace = json['total_space'];
    buildingSpace = json['building_space'];
    apartmentFloorNumber = json['apartment_floor_number'];
    status = json['status'];
    sId = json['_id'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_space'] = this.totalSpace;
    data['building_space'] = this.buildingSpace;
    data['apartment_floor_number'] = this.apartmentFloorNumber;
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String? name;
  String? image;
  String? space;
  String? sId;

  Rooms({this.name, this.image, this.space, this.sId});

  Rooms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    space = json['space'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['space'] = this.space;
    data['_id'] = this.sId;
    return data;
  }
}
