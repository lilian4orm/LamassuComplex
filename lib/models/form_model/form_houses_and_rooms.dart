class HousesandRoomModel {
  bool? error;
  String? message;
  List<ResultsHouseAndRoomform>? results;
  String? contentUrl;

  HousesandRoomModel({this.error, this.message, this.results, this.contentUrl});

  HousesandRoomModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <ResultsHouseAndRoomform>[];
      json['results'].forEach((v) {
        results!.add(new ResultsHouseAndRoomform.fromJson(v));
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

class ResultsHouseAndRoomform {
  String? sId;
  String? name;
  String? status;
  dynamic totalSpace;
  dynamic buildingSpace;
  dynamic apartmentFloorNumber;
  List<Rooms>? rooms;

  ResultsHouseAndRoomform(
      {this.sId,
        this.name,
        this.status,
        this.totalSpace,
        this.buildingSpace,
        this.apartmentFloorNumber,
        this.rooms});

  ResultsHouseAndRoomform.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    totalSpace = json['total_space'];
    buildingSpace = json['building_space'];
    apartmentFloorNumber = json['apartment_floor_number'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['total_space'] = this.totalSpace;
    data['building_space'] = this.buildingSpace;
    data['apartment_floor_number'] = this.apartmentFloorNumber;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String? name;
  String? image;
  dynamic space;
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