class TicketResponseModel {
  bool? status;
  String? message;
  TicketData? data;

  TicketResponseModel({this.status, this.message, this.data});

  TicketResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TicketData.fromJson(json['data']) : null;
  }
}

class TicketData {
  int? ticketId;
  String? status;

  TicketData({this.ticketId, this.status});

  TicketData.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    status = json['status'];
  }
}