class AboutUsModel {
  bool? status;
  String? data;

  AboutUsModel({this.status, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }
}