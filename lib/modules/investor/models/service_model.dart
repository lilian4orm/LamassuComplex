class ReportServiceModel {
  All? all;
  All? today;

  ReportServiceModel({this.all, this.today});

  ReportServiceModel.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    today = json['today'] != null ? new All.fromJson(json['today']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.all != null) {
      data['all'] = this.all!.toJson();
    }
    if (this.today != null) {
      data['today'] = this.today!.toJson();
    }
    return data;
  }
}

class All {
  int? salaryAmount;
  int? paymentAmount;
  int? discountAmount;
  int? remaining;

  All(
      {this.salaryAmount,
      this.paymentAmount,
      this.discountAmount,
      this.remaining});

  All.fromJson(Map<String, dynamic> json) {
    salaryAmount = json['salaryAmount'];
    paymentAmount = json['paymentAmount'];
    discountAmount = json['discountAmount'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salaryAmount'] = this.salaryAmount;
    data['paymentAmount'] = this.paymentAmount;
    data['discountAmount'] = this.discountAmount;
    data['remaining'] = this.remaining;
    return data;
  }
}
