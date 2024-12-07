class ReportMoneyModel {
  All? all;
  Today? today;

  ReportMoneyModel({this.all, this.today});

  ReportMoneyModel.fromJson(Map<String, dynamic> json) {
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
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
  int? salaryAmountOwner;
  int? paymentAmountOwner;
  int? discountAmountOwner;
  int? remainingAmountOwner;

  All(
      {this.salaryAmountOwner,
      this.paymentAmountOwner,
      this.discountAmountOwner,
      this.remainingAmountOwner});

  All.fromJson(Map<String, dynamic> json) {
    salaryAmountOwner = json['salaryAmountOwner'];
    paymentAmountOwner = json['paymentAmountOwner'];
    discountAmountOwner = json['discountAmountOwner'];
    remainingAmountOwner = json['remainingAmountOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salaryAmountOwner'] = this.salaryAmountOwner;
    data['paymentAmountOwner'] = this.paymentAmountOwner;
    data['discountAmountOwner'] = this.discountAmountOwner;
    data['remainingAmountOwner'] = this.remainingAmountOwner;
    return data;
  }
}

class Today {
  int? salaryAmount;
  int? paymentAmount;
  int? discountAmount;

  Today({this.salaryAmount, this.paymentAmount, this.discountAmount});

  Today.fromJson(Map<String, dynamic> json) {
    salaryAmount = json['salaryAmount'];
    paymentAmount = json['paymentAmount'];
    discountAmount = json['discountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salaryAmount'] = this.salaryAmount;
    data['paymentAmount'] = this.paymentAmount;
    data['discountAmount'] = this.discountAmount;
    return data;
  }
}
