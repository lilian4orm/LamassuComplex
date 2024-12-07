class SalaryServicesModel {
  bool? error;
  String? message;
  List<ResultsSalary>? results;
  Statistics? statistics;
  String? contentUrl;

  SalaryServicesModel(
      {this.error,
      this.message,
      this.results,
      this.statistics,
      this.contentUrl});

  SalaryServicesModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <ResultsSalary>[];
      json['results'].forEach((v) {
        results!.add(new ResultsSalary.fromJson(v));
      });
    }
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    data['content_url'] = this.contentUrl;
    return data;
  }
}

class ResultsSalary {
  String? sId;
  String? ownerId;
  String? desc;
  String? serviceId;
  String? centerId;
  bool? isDeleted;
  String? date;
  String? invoiceNumber;
  List<Payments>? payments;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? salaryAmount;
  int? discountAmount;
  int? paymentAmount;
  int? remainingAll;
  String? serviceName;
  String? serviceType;

  ResultsSalary(
      {this.sId,
      this.ownerId,
      this.desc,
      this.serviceId,
      this.centerId,
      this.isDeleted,
      this.date,
      this.invoiceNumber,
      this.payments,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.salaryAmount,
      this.discountAmount,
      this.paymentAmount,
      this.remainingAll,
      this.serviceName,
      this.serviceType});

  ResultsSalary.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ownerId = json['owner_id'];
    desc = json['desc'];
    serviceId = json['service_id'];
    centerId = json['center_id'];
    isDeleted = json['is_deleted'];
    date = json['date'];
    invoiceNumber = json['invoice_number'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    salaryAmount = json['salaryAmount'];
    discountAmount = json['discountAmount'];
    paymentAmount = json['paymentAmount'];
    remainingAll = json['remainingAll'];
    serviceName = json['service_name'];
    serviceType = json['service_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['owner_id'] = this.ownerId;
    data['desc'] = this.desc;
    data['service_id'] = this.serviceId;
    data['center_id'] = this.centerId;
    data['is_deleted'] = this.isDeleted;
    data['date'] = this.date;
    data['invoice_number'] = this.invoiceNumber;
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['salaryAmount'] = this.salaryAmount;
    data['discountAmount'] = this.discountAmount;
    data['paymentAmount'] = this.paymentAmount;
    data['remainingAll'] = this.remainingAll;
    data['service_name'] = this.serviceName;
    data['service_type'] = this.serviceType;
    return data;
  }
}

class Payments {
  int? amount;
  String? type;
  String? desc;
  bool? isDeleted;
  int? exchangeRate;
  String? invoiceNumber;
  String? date;
  bool? isDollar;
  String? sId;

  Payments(
      {this.amount,
      this.type,
      this.desc,
      this.isDeleted,
      this.exchangeRate,
      this.invoiceNumber,
      this.date,
      this.isDollar,
      this.sId});

  Payments.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
    desc = json['desc'];
    isDeleted = json['is_deleted'];
    exchangeRate = json['exchange_rate'];
    invoiceNumber = json['invoice_number'];
    date = json['date'];
    isDollar = json['is_dollar'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['desc'] = this.desc;
    data['is_deleted'] = this.isDeleted;
    data['exchange_rate'] = this.exchangeRate;
    data['invoice_number'] = this.invoiceNumber;
    data['date'] = this.date;
    data['is_dollar'] = this.isDollar;
    data['_id'] = this.sId;
    return data;
  }
}

class Statistics {
  String? nId;
  int? totalSalary;
  int? totalDiscount;
  int? totalPayment;
  int? totalRemaining;

  Statistics(
      {this.nId,
      this.totalSalary,
      this.totalDiscount,
      this.totalPayment,
      this.totalRemaining});

  Statistics.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    totalSalary = json['totalSalary'];
    totalDiscount = json['totalDiscount'];
    totalPayment = json['totalPayment'];
    totalRemaining = json['totalRemaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['totalSalary'] = this.totalSalary;
    data['totalDiscount'] = this.totalDiscount;
    data['totalPayment'] = this.totalPayment;
    data['totalRemaining'] = this.totalRemaining;
    return data;
  }
}
