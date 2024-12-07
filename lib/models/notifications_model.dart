class NotificationResponse {
  bool? error;
  String? message;
  NotificationResults? results;
  String? contentUrl;

  NotificationResponse(
      {this.error, this.message, this.results, this.contentUrl});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    results =
    json['results'] != null ? new NotificationResults.fromJson(json['results']) : null;
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    data['content_url'] = this.contentUrl;
    return data;
  }
}

class NotificationResults {
  List<NotificationData>? data;
  int? count;

  NotificationResults({this.data, this.count});

  NotificationResults.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class NotificationData {
  String? sId;
  String? title;
  String? body;
  String? image;
  String? type;
  String? link;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationData(
      {this.sId,
        this.title,
        this.body,
        this.image,
        this.type,
        this.link,
        this.centerId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    type = json['type'];
    link = json['link'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    data['type'] = this.type;
    data['link'] = this.link;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}