class AboutAppModel {
  bool? error;
  String? message;
  String? contentUrl;
  Results? results;

  AboutAppModel({this.error, this.message, this.contentUrl, this.results});

  AboutAppModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    contentUrl = json['content_url'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['content_url'] = this.contentUrl;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  String? sId;
  String? name;
  String? logo;
  String? description;
  String? address;
  String? phone;
  String? website;
  String? facebook;
  String? instagram;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Results(
      {this.sId,
        this.name,
        this.logo,
        this.description,
        this.address,
        this.phone,
        this.website,
        this.facebook,
        this.instagram,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    address = json['address'];
    phone = json['phone'];
    website = json['website'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}


