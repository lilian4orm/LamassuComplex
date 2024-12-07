class OwnerProfileModel {
  bool? error;
  String? message;
  Results? results;
  String? contentUrl;

  OwnerProfileModel({this.error, this.message, this.results, this.contentUrl});

  OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
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

class Results {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? buildingNo;
  String? floor;
  String? houseNo;
  String? image;
  int? salary;
  List<SalaryStaff>? salaryStaff;

  Results(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.buildingNo,
      this.floor,
      this.houseNo,
      this.image,
      this.salary,
      this.salaryStaff});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    buildingNo = json['form_exact_apartment_building'];
    floor = json['apartment_floor_number'];
    houseNo = json['house_name'];
    image = json['image'];
    salary = json['salary'];
    if (json['salary_staff'] != null) {
      salaryStaff = <SalaryStaff>[];
      json['salary_staff'].forEach((v) {
        salaryStaff!.add(SalaryStaff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['form_exact_apartment_building'] = buildingNo;
    data['house_name'] = houseNo;
    data['apartment_floor_number'] = floor;
    data['image'] = this.image;
    data['salary'] = this.salary;
    if (this.salaryStaff != null) {
      data['salary_staff'] = this.salaryStaff!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalaryStaff {
  String? sId;
  String? accountId;
  int? amount;
  String? centerId;
  bool? isDeleted;
  String? paymentDate;
  List<Discounts>? discounts;
  List<Additional>? additional;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? allDiscounts;
  int? allAdditional;
  int? pureMoney;

  SalaryStaff(
      {this.sId,
      this.accountId,
      this.amount,
      this.centerId,
      this.isDeleted,
      this.paymentDate,
      this.discounts,
      this.additional,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.allDiscounts,
      this.allAdditional,
      this.pureMoney});

  SalaryStaff.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountId = json['account_id'];
    amount = json['amount'];
    centerId = json['center_id'];
    isDeleted = json['is_deleted'];
    paymentDate = json['payment_date'];
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(Discounts.fromJson(v));
      });
    }
    if (json['additional'] != null) {
      additional = <Additional>[];
      json['additional'].forEach((v) {
        additional!.add(Additional.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    allDiscounts = json['allDiscounts'];
    allAdditional = json['allAdditional'];
    pureMoney = json['pureMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['account_id'] = this.accountId;
    data['amount'] = this.amount;
    data['center_id'] = this.centerId;
    data['is_deleted'] = this.isDeleted;
    data['payment_date'] = this.paymentDate;
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    if (this.additional != null) {
      data['additional'] = this.additional!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.v;
    data['allDiscounts'] = this.allDiscounts;
    data['allAdditional'] = this.allAdditional;
    data['pureMoney'] = this.pureMoney;
    return data;
  }
}

class Discounts {
  int? price;
  String? countingServiceSalary;
  dynamic note;
  String? sId;

  Discounts({this.price, this.countingServiceSalary, this.note, this.sId});

  Discounts.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    countingServiceSalary = json['counting_service_salary'];
    note = json['note'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['counting_service_salary'] = this.countingServiceSalary;
    data['note'] = this.note;
    data['_id'] = this.sId;
    return data;
  }
}

class Additional {
  int? price;
  String? countingServiceSalary;
  String? note;
  String? sId;

  Additional({this.price, this.countingServiceSalary, this.note, this.sId});

  Additional.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    countingServiceSalary = json['counting_service_salary'];
    note = json['note'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['counting_service_salary'] = this.countingServiceSalary;
    data['note'] = this.note;
    data['_id'] = this.sId;
    return data;
  }
}
