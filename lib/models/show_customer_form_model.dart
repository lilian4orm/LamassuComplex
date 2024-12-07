class ShowCustomerFormModel {
  bool? error;
  String? message;
  Results? results;
  String? contentUrl;

  ShowCustomerFormModel({this.error, this.message, this.results, this.contentUrl});

  ShowCustomerFormModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
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
  String? callerName;
  String? callerJob;
  String? callerPhone;
  String? callerGovernorate;
  String? callerAddress;
  int? callerFamilyMembers;
  String? howHeHearAboutUs;
  String? spaceRequired;
  String? callReason;
  String? createdAt;
  bool? transferredApplicationForm;
  String? formName;
  bool? isYours;

  Data(
      {this.sId,
        this.callerName,
        this.callerJob,
        this.callerPhone,
        this.callerGovernorate,
        this.callerAddress,
        this.callerFamilyMembers,
        this.howHeHearAboutUs,
        this.spaceRequired,
        this.callReason,
        this.createdAt,
        this.transferredApplicationForm,
        this.formName,
        this.isYours});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    callerName = json['caller_name'];
    callerJob = json['caller_job'];
    callerPhone = json['caller_phone'];
    callerGovernorate = json['caller_governorate'];
    callerAddress = json['caller_address'];
    callerFamilyMembers = json['caller_family_members'];
    howHeHearAboutUs = json['how_he_hear_about_us'];
    spaceRequired = json['space_required'];
    callReason = json['call_reason'];
    createdAt = json['createdAt'];
    transferredApplicationForm = json['is_transferred_to_application_form'];
    formName = json['form_name'];
    isYours = json['is_yours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caller_name'] = this.callerName;
    data['caller_job'] = this.callerJob;
    data['caller_phone'] = this.callerPhone;
    data['caller_governorate'] = this.callerGovernorate;
    data['caller_address'] = this.callerAddress;
    data['caller_family_members'] = this.callerFamilyMembers;
    data['how_he_hear_about_us'] = this.howHeHearAboutUs;
    data['space_required'] = this.spaceRequired;
    data['call_reason'] = this.callReason;
    data['createdAt'] = this.createdAt;
    data['is_transferred_to_application_form'] = this.transferredApplicationForm;
    data['form_name'] = this.formName;
    data['is_yours'] = this.isYours;
    return data;
  }
}


