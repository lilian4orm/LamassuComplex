class SalaryOwnerModel {
  bool? error;
  String? message;
  List<Results>? results;
  Statistics? statistics;
  String? contentUrl;

  SalaryOwnerModel(
      {this.error,
      this.message,
      this.results,
      this.statistics,
      this.contentUrl});

  SalaryOwnerModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = error;
    data['message'] = message;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['statistics'] = statistics?.toJson();
    data['content_url'] = contentUrl;
    return data;
  }
}

class Results {
  String? sId;
  String? ownerId;
  String? desc;
  String? houseId;
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
  String? name;
  String? phone;
  String? nextPaymentDate;
  int? remainingAll;
  String? houseName;
  String? houseExistingType;
  String? formCode;

  Results({
    this.sId,
    this.ownerId,
    this.desc,
    this.houseId,
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
    this.name,
    this.phone,
    this.nextPaymentDate,
    this.remainingAll,
    this.houseName,
    this.houseExistingType,
    this.formCode,
  });

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ownerId = json['owner_id'];
    desc = json['desc'];
    houseId = json['house_id'];
    centerId = json['center_id'];
    isDeleted = json['is_deleted'];
    date = json['date'];
    invoiceNumber = json['invoice_number'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    salaryAmount = json['salaryAmount'];
    discountAmount = json['discountAmount'];
    paymentAmount = json['paymentAmount'];
    name = json['name'];
    phone = json['phone'];
    nextPaymentDate = json['nextPaymentDate'];
    remainingAll = json['remainingAll'];
    houseName = json['house_name'];
    houseExistingType = json['house_existing_type'];
    formCode = json['form_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['owner_id'] = ownerId;
    data['desc'] = desc;
    data['house_id'] = houseId;
    data['center_id'] = centerId;
    data['is_deleted'] = isDeleted;
    data['date'] = date;
    data['invoice_number'] = invoiceNumber;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['salaryAmount'] = salaryAmount;
    data['discountAmount'] = discountAmount;
    data['paymentAmount'] = paymentAmount;
    data['name'] = name;
    data['phone'] = phone;
    data['nextPaymentDate'] = nextPaymentDate;
    data['remainingAll'] = remainingAll;
    data['house_name'] = houseName;
    data['house_existing_type'] = houseExistingType;
    data['form_code'] = formCode;
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
  String? status;
  bool? isDollar;
  String? sId;

  Payments({
    this.amount,
    this.type,
    this.desc,
    this.isDeleted,
    this.exchangeRate,
    this.invoiceNumber,
    this.date,
    this.status,
    this.isDollar,
    this.sId,
  });

  Payments.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
    desc = json['desc'];
    isDeleted = json['is_deleted'];
    exchangeRate = json['exchange_rate'];
    invoiceNumber = json['invoice_number'];
    date = json['date'];
    status = json['status'];
    isDollar = json['is_dollar'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = amount;
    data['type'] = type;
    data['desc'] = desc;
    data['is_deleted'] = isDeleted;
    data['exchange_rate'] = exchangeRate;
    data['invoice_number'] = invoiceNumber;
    data['date'] = date;
    data['status'] = status;
    data['is_dollar'] = isDollar;
    data['_id'] = sId;
    return data;
  }
}

class Statistics {
  String? sId;
  int? totalSalary;
  int? totalDiscount;
  int? totalPayment;
  bool? isDollar;
  int? totalRemaining;

  Statistics(
      {this.sId,
      this.totalSalary,
      this.totalDiscount,
      this.totalPayment,
      this.isDollar,
      this.totalRemaining});

  Statistics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalSalary = json['totalSalary'];
    isDollar = json['is_dollar'];
    totalDiscount = json['totalDiscount'];
    totalPayment = json['totalPayment'];
    totalRemaining = json['totalRemaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['totalSalary'] = totalSalary;
    data['totalDiscount'] = totalDiscount;
    data['totalPayment'] = totalPayment;
    data['is_dollar'] = isDollar;
    data['totalRemaining'] = totalRemaining;
    return data;
  }
}
