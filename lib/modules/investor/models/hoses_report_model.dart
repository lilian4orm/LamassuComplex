class ReportHouseModel {
  int? numberOfHouses;
  int? numberOfSoldHouses;
  int? numberOfReceivedHouses;

  ReportHouseModel(
      {this.numberOfHouses,
      this.numberOfSoldHouses,
      this.numberOfReceivedHouses});

  ReportHouseModel.fromJson(Map<String, dynamic> json) {
    numberOfHouses = json['number_of_houses'];
    numberOfSoldHouses = json['number_of_sold_houses'];
    numberOfReceivedHouses = json['number_of_received_houses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_of_houses'] = this.numberOfHouses;
    data['number_of_sold_houses'] = this.numberOfSoldHouses;
    data['number_of_received_houses'] = this.numberOfReceivedHouses;
    return data;
  }
}
