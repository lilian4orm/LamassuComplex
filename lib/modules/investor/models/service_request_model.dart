class ReportServiceRequestModel {
  List<All>? all;
  List<Today>? today;

  ReportServiceRequestModel({this.all, this.today});

  ReportServiceRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v) {
        today!.add(new Today.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.map((v) => v.toJson()).toList();
    }
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class All {
  String? sId;
  int? count;

  All({this.sId, this.count});

  All.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    return data;
  }
}

class Today {
  String? sId;
  int? count;

  Today({this.sId, this.count});

  Today.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    return data;
  }
}
