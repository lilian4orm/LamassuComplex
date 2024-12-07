class ApartmentTowersModel {
  bool? error;
  List<Results>? results;
  String? contentUrl;

  ApartmentTowersModel({this.error, this.results, this.contentUrl});

  ApartmentTowersModel.fromJson(Map<String, dynamic> json) {
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
  String? exactApartmentBuilding;

  Results({this.sId, this.exactApartmentBuilding});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    exactApartmentBuilding = json['exact_apartment_building'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['exact_apartment_building'] = this.exactApartmentBuilding;
    return data;
  }
}


