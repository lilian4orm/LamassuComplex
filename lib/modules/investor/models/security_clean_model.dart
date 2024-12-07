class ReportSecurityCleanModel {
  IsPaid? isPaid;
  IsPaid? notPaid;
  int? todayPaidCount;
  TodayPaidPrice? todayPaidPrice;

  ReportSecurityCleanModel(
      {this.isPaid, this.notPaid, this.todayPaidCount, this.todayPaidPrice});

  ReportSecurityCleanModel.fromJson(Map<String, dynamic> json) {
    isPaid =
        json['is_paid'] != null ? new IsPaid.fromJson(json['is_paid']) : null;
    notPaid =
        json['not_paid'] != null ? new IsPaid.fromJson(json['not_paid']) : null;
    todayPaidCount = json['today_paid_count'];
    todayPaidPrice = json['today_paid_price'] != null
        ? new TodayPaidPrice.fromJson(json['today_paid_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.isPaid != null) {
      data['is_paid'] = this.isPaid!.toJson();
    }
    if (this.notPaid != null) {
      data['not_paid'] = this.notPaid!.toJson();
    }
    data['today_paid_count'] = this.todayPaidCount;
    if (this.todayPaidPrice != null) {
      data['today_paid_price'] = this.todayPaidPrice!.toJson();
    }
    return data;
  }
}

class IsPaid {
  int? totalPrice;
  int? count;

  IsPaid({this.totalPrice, this.count});

  IsPaid.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    data['count'] = this.count;
    return data;
  }
}

class TodayPaidPrice {
  int? totalPrice;

  TodayPaidPrice({this.totalPrice});

  TodayPaidPrice.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    return data;
  }
}
