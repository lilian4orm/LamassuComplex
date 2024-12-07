class lastNewsModel {
  List<Results>? results;
  String? message;
  bool? error;
  String? contentUrl;

  lastNewsModel({this.results, this.message, this.error, this.contentUrl});

  lastNewsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    data['content_url'] = this.contentUrl;
    return data;
  }
}

class Results {
  String? sId;
  String? image;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? description;
  String? title;

  Results(
      {this.sId,
        this.image,
        this.centerId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.description,
        this.title});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}