class ShipingResponeModel {
  String? sId;
  String? machineName;
  String? roomName;
  String? fixType;
  String? createdAt;
  CurrentStatus? currentStatus;
  Service? service;

  ShipingResponeModel(
      {this.sId,
      this.machineName,
      this.roomName,
      this.fixType,
      this.createdAt,
      this.currentStatus,
      this.service});

  ShipingResponeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    machineName = json['machine_name'];
    roomName = json['room_name'];
    fixType = json['fix_type'];
    createdAt = json['createdAt'];
    currentStatus = json['current_status'] != null
        ? new CurrentStatus.fromJson(json['current_status'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['machine_name'] = this.machineName;
    data['room_name'] = this.roomName;
    data['fix_type'] = this.fixType;
    data['createdAt'] = this.createdAt;
    if (this.currentStatus != null) {
      data['current_status'] = this.currentStatus!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class CurrentStatus {
  String? type;
  String? note;
  String? insertBy;
  int? employeeId;
  String? dateToWork;
  String? reasonToReject;
  String? createdAt;
  String? sId;
  String? employeeName;

  CurrentStatus(
      {this.type,
      this.note,
      this.insertBy,
      this.employeeId,
      this.dateToWork,
      this.reasonToReject,
      this.createdAt,
      this.sId,
      this.employeeName});

  CurrentStatus.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    note = json['note'];
    insertBy = json['insert_by'];
    employeeId = json['employee_id'];
    dateToWork = json['date_to_work'];
    reasonToReject = json['reason_to_reject'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    employeeName = json['employee_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['note'] = this.note;
    data['insert_by'] = this.insertBy;
    data['employee_id'] = this.employeeId;
    data['date_to_work'] = this.dateToWork;
    data['reason_to_reject'] = this.reasonToReject;
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    data['employee_name'] = this.employeeName;
    return data;
  }
}

class Service {
  String? sId;
  String? name;
  int? price;

  Service({this.sId, this.name, this.price});

  Service.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
