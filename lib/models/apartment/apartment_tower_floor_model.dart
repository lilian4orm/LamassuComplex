class ApartmentTowerAndFloorModel {
  bool? error;
  List<Results>? results;
  String? contentUrl;

  ApartmentTowerAndFloorModel({this.error, this.results, this.contentUrl});

  ApartmentTowerAndFloorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
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
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['content_url'] = this.contentUrl;
    return data;
  }
}

class Results {
  String? sId;
  String? name;
  String? centerFormId;
  String? centerId;
  String? exactApartmentBuilding;
  var totalSpace;
  var buildingSpace;
  String? apartmentFloorNumber;
  List<Rooms>? rooms;
  String? status;
  var iV;
  var apartmentFloorOrder;

  Results(
      {this.sId,
        this.name,
        this.centerFormId,
        this.centerId,
        this.exactApartmentBuilding,
        this.totalSpace,
        this.buildingSpace,
        this.apartmentFloorNumber,
        this.rooms,
        this.status,
        this.iV,
        this.apartmentFloorOrder});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    centerFormId = json['center_form_id'];
    centerId = json['center_id'];
    exactApartmentBuilding = json['exact_apartment_building'];
    totalSpace = json['total_space'];
    buildingSpace = json['building_space'];
    apartmentFloorNumber = json['apartment_floor_number'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
    status = json['status'];
    iV = json['__v'];
    apartmentFloorOrder = json['apartment_floor_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['center_form_id'] = this.centerFormId;
    data['center_id'] = this.centerId;
    data['exact_apartment_building'] = this.exactApartmentBuilding;
    data['total_space'] = this.totalSpace;
    data['building_space'] = this.buildingSpace;
    data['apartment_floor_number'] = this.apartmentFloorNumber;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['__v'] = this.iV;
    data['apartment_floor_order'] = this.apartmentFloorOrder;
    return data;
  }
}

class Rooms {
  String? name;
  String? image;
  var space;
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

