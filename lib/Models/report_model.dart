class FaultModel {
  int? id;
  String? details;
  String? faultCategories;
  String? dateTime;
  String? status;
  String? image;
  String? longitude;
  String? latitude;
  String? recipient;
  String? updatedStatus;
  String? imageUrl;

  FaultModel(
      {this.id,
        this.details,
        this.faultCategories,
        this.dateTime,
        this.status,
        this.image,
        this.longitude,
        this.latitude,
        this.recipient,
        this.updatedStatus,
        this.imageUrl
      });

  FaultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    faultCategories = json['faultCategories'];
    dateTime = json['dateTime'];
    status = json['status'];
    image = json['image'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    recipient = json['recipient'];
    updatedStatus= json['updatedStatus'];
    imageUrl= json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['faultCategories'] = this.faultCategories;
    data['dateTime'] = this.dateTime;
    data['status'] = this.status;
    data['image'] = this.image;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['recipient'] = this.recipient;
    data['updatedStatus'] = this.updatedStatus;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}