class ReportModel {
  int? id;
  String? details;
  String? faultCategories;
  String? dateTime;
  String? status;
  String? image;
  String? latitudeController;
  String? longitudeController;
  Null? recipient;

  ReportModel(
      {this.id,
        this.details,
        this.faultCategories,
        this.dateTime,
        this.status,
        this.image,
        this.latitudeController,
        this.longitudeController,
        this.recipient});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    faultCategories = json['faultCategories'];
    dateTime = json['dateTime'];
    status = json['status'];
    image = json['image'];
    latitudeController = json['latitudeController'];
    longitudeController = json['longitudeController'];
    recipient = json['recipient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['faultCategories'] = this.faultCategories;
    data['dateTime'] = this.dateTime;
    data['status'] = this.status;
    data['image'] = this.image;
    data['latitudeController'] = this.latitudeController;
    data['longitudeController'] = this.longitudeController;
    data['recipient'] = this.recipient;
    return data;
  }
}