class Advantages {
  List<ResultsAdvantages>? results;
  String? message;
  bool? error;
  String? contentUrl;

  Advantages({this.results, this.message, this.error, this.contentUrl});

  Advantages.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ResultsAdvantages>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAdvantages.fromJson(v));
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

class ResultsAdvantages {
  String? sId;
  String? title;
  String? image;
  String? note;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ResultsAdvantages(
      {this.sId,
      this.title,
      this.image,
      this.note,
      this.centerId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ResultsAdvantages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    note = json['note'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['note'] = this.note;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
