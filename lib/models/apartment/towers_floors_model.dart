class TowersFloorsModel {
  bool? error;
  List<Results>? results;
  String? contentUrl;

  TowersFloorsModel({this.error, this.results, this.contentUrl});

  TowersFloorsModel.fromJson(Map<String, dynamic> json) {
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
  String? apartmentFloorNumber;

  Results({this.sId, this.apartmentFloorNumber});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    apartmentFloorNumber = json['apartment_floor_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['apartment_floor_number'] = this.apartmentFloorNumber;
    return data;
  }
}