class MyExperienceModel {
  Results? results;
  String? message;
  bool? error;
  String? contentUrl;

  MyExperienceModel({this.results, this.message, this.error, this.contentUrl});

  MyExperienceModel.fromJson(Map<String, dynamic> json) {
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
    message = json['message'];
    error = json['error'];
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    data['content_url'] = this.contentUrl;
    return data;
  }
}

class Results {
  String? sId;
  String? name;
  String? address;
  String? phone;
  String? whatsapp;
  String? facebook;
  String? logo;
  String? snapchat;
  String? instagram;
  String? tiktok;
  String? description;
  String? video;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Results(
      {this.sId,
        this.name,
        this.address,
        this.phone,
        this.whatsapp,
        this.facebook,
        this.logo,
        this.snapchat,
        this.instagram,
        this.tiktok,
        this.description,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    logo = json['logo'];
    snapchat = json['snapchat'];
    instagram = json['instagram'];
    tiktok = json['tiktok'];
    description = json['description'];
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['facebook'] = this.facebook;
    data['logo'] = this.logo;
    data['snapchat'] = this.snapchat;
    data['instagram'] = this.instagram;
    data['tiktok'] = this.tiktok;
    data['description'] = this.description;
    data['video'] = this.video;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
