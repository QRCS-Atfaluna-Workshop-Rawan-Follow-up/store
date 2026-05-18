class OtpResponseModel {
  String? message;
  String? status;
  String? nextStep;
  String? otp; // السيرفر يرسله كنص "1234"

  OtpResponseModel({
    this.message,
    this.status,
    this.nextStep,
    this.otp,
  });

  // تحويل البيانات من JSON إلى Model
  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      message: json['message'],
      status: json['status'],
      nextStep: json['next_step'], // لاحظي التحويل من snake_case إلى camelCase
      otp: json['token'],
    );
  }

  // تحويل البيانات من Model إلى JSON (إذا لزم الأمر لاحقاً)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['next_step'] = nextStep;
    data['token'] = otp;
    return data;
  }
}