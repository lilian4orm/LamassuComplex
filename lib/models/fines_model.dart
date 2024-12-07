class FinesModel {
  String? sId;
  int? amount;
  String? date;
  String? note;
  bool? isPaid;
  String? fineType;
  String? fineReason;
  String? finesTypeName;
  String? paidDate;

  FinesModel(
      {this.sId,
      this.amount,
      this.date,
      this.note,
      this.isPaid,
      this.fineType,
      this.fineReason,
      this.finesTypeName,
      this.paidDate});

  FinesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amount = json['amount'];
    date = json['date'];
    note = json['note'];
    isPaid = json['is_paid'];
    fineType = json['fine_type'];
    fineReason = json['fine_reason'];
    finesTypeName = json['fines_type_name'];
    paidDate = json['paid_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['note'] = this.note;
    data['is_paid'] = this.isPaid;
    data['fine_type'] = this.fineType;
    data['fine_reason'] = this.fineReason;
    data['fines_type_name'] = this.finesTypeName;
    data['paid_date'] = this.paidDate;
    return data;
  }
}
