// class AddressResponse {
//   bool? status;
//   List<AddressData>? data;
//
//   AddressResponse({this.status, this.data});
//
//   AddressResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <AddressData>[];
//       json['data'].forEach((v) {
//         data!.add(AddressData.fromJson(v));
//       });
//     }
//   }
// }
//
// class AddressData {
//   int? id;
//   int? customerId;
//   String? title;
//   String? addressType;
//   String? buildingName;
//   String? recipientName;
//   String? street;
//   String? nearestLandmark;
//   String? city;
//   String? area;
//   String? block;
//   String? avenue;
//   String? buildingNumber;
//   String? postalCode;
//   String? countryCode;
//   String? mobile;
//   String? specialInstructions;
//   String? createdAt;
//   String? updatedAt;
//   String? latitude;
//   String? longitude;
//   int? isBilling;
//
//   AddressData({
//     this.id,
//     this.customerId,
//     this.title,
//     this.addressType,
//     this.buildingName,
//     this.recipientName,
//     this.street,
//     this.nearestLandmark,
//     this.city,
//     this.area,
//     this.block,
//     this.avenue,
//     this.buildingNumber,
//     this.postalCode,
//     this.countryCode,
//     this.mobile,
//     this.specialInstructions,
//     this.createdAt,
//     this.updatedAt,
//     this.latitude,
//     this.longitude,
//     this.isBilling,
//   });
//
//   AddressData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     customerId = json['customer_id'];
//     title = json['title'];
//     addressType = json['address_type'];
//     buildingName = json['building_name'];
//     recipientName = json['recipient_name'];
//     street = json['street'];
//     nearestLandmark = json['nearest_landmark'];
//     city = json['city'];
//     area = json['area'];
//     block = json['block'];
//     avenue = json['avenue'];
//     buildingNumber = json['building_number'];
//     postalCode = json['postal_code'];
//     countryCode = json['country_code'];
//     mobile = json['mobile'];
//     specialInstructions = json['special_instructions'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     isBilling = json['is_billing'];
//   }
// }

class AddressResponseModel {
  bool? status;
  List<AddressModel>? data;

  AddressResponseModel({this.status, this.data});

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AddressModel>[];
      json['data'].forEach((v) {
        data!.add(AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressModel {
  int? id;
  int? customerId;
  String? title;
  String? addressType;
  String? buildingName;
  String? recipientName;
  String? street;
  String? nearestLandmark;
  String? city;
  String? area;
  String? block;
  String? avenue;
  String? buildingNumber;
  String? postalCode;
  String? countryCode;
  String? mobile;
  String? specialInstructions;
  String? createdAt;
  String? updatedAt;
  double? latitude; // 💡 تم جعلها double? للتعامل مع الـ null بسلاسة
  double? longitude; // 💡 تم جعلها double? للتعامل مع الـ null بسلاسة
  int? isBilling;

  AddressModel({
    this.id,
    this.customerId,
    this.title,
    this.addressType,
    this.buildingName,
    this.recipientName,
    this.street,
    this.nearestLandmark,
    this.city,
    this.area,
    this.block,
    this.avenue,
    this.buildingNumber,
    this.postalCode,
    this.countryCode,
    this.mobile,
    this.specialInstructions,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.isBilling,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    title = json['title'];
    addressType = json['address_type'];
    buildingName = json['building_name'];
    recipientName = json['recipient_name'];
    street = json['street'];
    nearestLandmark = json['nearest_landmark'];
    city = json['city'];
    area = json['area'];
    block = json['block'];
    avenue = json['avenue'];
    buildingNumber = json['building_number'];
    postalCode = json['postal_code'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    specialInstructions = json['special_instructions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    // تأمين تحويل الـ الاحداثيات لـ double بأمان حتى لو جاءت أرقام صحيحة أو null
    latitude = json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null;
    longitude = json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null;

    isBilling = json['is_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['title'] = title;
    data['address_type'] = addressType;
    data['building_name'] = buildingName;
    data['recipient_name'] = recipientName;
    data['street'] = street;
    data['nearest_landmark'] = nearestLandmark;
    data['city'] = city;
    data['area'] = area;
    data['block'] = block;
    data['avenue'] = avenue;
    data['building_number'] = buildingNumber;
    data['postal_code'] = postalCode;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['special_instructions'] = specialInstructions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    return data;
  }
}