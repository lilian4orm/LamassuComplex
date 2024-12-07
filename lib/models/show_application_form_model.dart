class ShowApplicationFormModel {
  bool? error;
  Results? results;

  ShowApplicationFormModel({this.error, this.results});

  ShowApplicationFormModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  List<Data>? data;
  int? count;

  Results({this.data, this.count});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  BuyerInfo? buyerInfo;
  HouseInfo? houseInfo;
  PaymentInfo? paymentInfo;
  String? insertedBy;
  String? centerId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? applicationCode;
  String? formName;
  // int? formTotalSpace;
  // int? formBuildingSpace;
  String? formBlockNumber;
  String? formStreetNumber;
  String? formCategory;
  String? formCode;
  String? houseName;

  Data(
      {this.sId,
        this.buyerInfo,
        this.houseInfo,
        this.paymentInfo,
        this.insertedBy,
        this.centerId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.applicationCode,
        this.formName,
        // this.formTotalSpace,
        // this.formBuildingSpace,
        this.formBlockNumber,
        this.formStreetNumber,
        this.formCategory,
        this.formCode,
        this.houseName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buyerInfo = json['buyer_info'] != null
        ? new BuyerInfo.fromJson(json['buyer_info'])
        : null;
    houseInfo = json['house_info'] != null
        ? new HouseInfo.fromJson(json['house_info'])
        : null;
    paymentInfo = json['payment_info'] != null
        ? new PaymentInfo.fromJson(json['payment_info'])
        : null;
    insertedBy = json['inserted_by'];
    centerId = json['center_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    applicationCode = json['application_code'];
    formName = json['form_name'];
    // formTotalSpace = json['form_total_space'];
    // formBuildingSpace = json['form_building_space'];
    formBlockNumber = json['form_block_number'];
    formStreetNumber = json['form_street_number'];
    formCategory = json['form_category'];
    formCode = json['form_code'];
    houseName = json['house_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.buyerInfo != null) {
      data['buyer_info'] = this.buyerInfo!.toJson();
    }
    if (this.houseInfo != null) {
      data['house_info'] = this.houseInfo!.toJson();
    }
    if (this.paymentInfo != null) {
      data['payment_info'] = this.paymentInfo!.toJson();
    }
    data['inserted_by'] = this.insertedBy;
    data['center_id'] = this.centerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['application_code'] = this.applicationCode;
    data['form_name'] = this.formName;
    // data['form_total_space'] = this.formTotalSpace;
    // data['form_building_space'] = this.formBuildingSpace;
    data['form_block_number'] = this.formBlockNumber;
    data['form_street_number'] = this.formStreetNumber;
    data['form_category'] = this.formCategory;
    data['form_code'] = this.formCode;
    data['house_name'] = this.houseName;
    return data;
  }
}

class BuyerInfo {
  String? customerName;
  String? customerPhone;
  String? idNumber;
  String? idIssueDate;
  String? idFrontImage;
  String? idBackImage;
  Address? address;
  String? email;
  int? familyNumber;
  String? job;
  String? jobType;

  BuyerInfo(
      {this.customerName,
        this.customerPhone,
        this.idNumber,
        this.idIssueDate,
        this.idFrontImage,
        this.idBackImage,
        this.address,
        this.email,
        this.familyNumber,
        this.job,
        this.jobType});

  BuyerInfo.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    idNumber = json['id_number'];
    idIssueDate = json['id_issue_date'];
    idFrontImage = json['id_front_image'];
    idBackImage = json['id_back_image'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    email = json['email'];
    familyNumber = json['family_number'];
    job = json['job'];
    jobType = json['job_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['id_number'] = this.idNumber;
    data['id_issue_date'] = this.idIssueDate;
    data['id_front_image'] = this.idFrontImage;
    data['id_back_image'] = this.idBackImage;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['email'] = this.email;
    data['family_number'] = this.familyNumber;
    data['job'] = this.job;
    data['job_type'] = this.jobType;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? house;

  Address({this.street, this.city, this.state, this.house});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    house = json['house'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['house'] = this.house;
    return data;
  }
}

class HouseInfo {
  String? formId;
  String? houseId;
  int? price;
  String? priceWritten;

  HouseInfo({this.formId, this.houseId, this.price, this.priceWritten});

  HouseInfo.fromJson(Map<String, dynamic> json) {
    formId = json['form_id'];
    houseId = json['house_id'];
    price = json['price'];
    priceWritten = json['price_written'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['form_id'] = this.formId;
    data['house_id'] = this.houseId;
    data['price'] = this.price;
    data['price_written'] = this.priceWritten;
    return data;
  }
}

class PaymentInfo {
  String? accountNumber;
  String? paymentType;
  int? managementFees;
  int? firstPayment;

  PaymentInfo(
      {this.accountNumber,
        this.paymentType,
        this.managementFees,
        this.firstPayment});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    paymentType = json['payment_type'];
    managementFees = json['management_fees'];
    firstPayment = json['first_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['payment_type'] = this.paymentType;
    data['management_fees'] = this.managementFees;
    data['first_payment'] = this.firstPayment;
    return data;
  }
}