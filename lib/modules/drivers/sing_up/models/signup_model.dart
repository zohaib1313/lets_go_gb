
class SignUpModel {

  String? id;
  String? adminId;
  String? firstName;
  String? userRole;
  String? emailAddress;
  String? phone;
  String? address;
  String? cnicFrontImageUrl;
  String? cnicBackImageUrl;
  String? driverLicenceImageUrl;
  String? password;
  String? confirmPassword;
  bool? success;
  String? errorMessage;

  SignUpModel({this.id,
    this.adminId,
    this.emailAddress,
    this.password,
    this.address,
    this.confirmPassword,
    this.firstName,
    this.userRole,
    this.phone,
    this.cnicBackImageUrl,
    this.cnicFrontImageUrl,
    this.driverLicenceImageUrl,
    this.success,
    this.errorMessage
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    id = json['Id'];
    adminId = json['AdminId'];
    emailAddress = json['EmailAddress'];
    firstName = json['FirstName'];
    userRole = json['UserRole'];
    address = json['Address'];
    phone = json['Phone'];
    cnicFrontImageUrl = json['CnicFrontImageUrl'];
    cnicBackImageUrl = json['CnicBackImageUrl'];
    driverLicenceImageUrl = json['DriverLicenceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Success'] = success;
    data['Id'] = id;
    data['AdminId'] = adminId;
    data['EmailAddress'] = emailAddress;
    data['FirstName'] = firstName;
    data['UserRole'] = userRole;
    data['Address'] = address;
    data['Phone'] = phone;
    data['CnicFrontImageUrl'] = cnicFrontImageUrl;
    data['CnicBackImageUrl'] = cnicBackImageUrl;
    data['DriverLicenceUrl'] = driverLicenceImageUrl;
    return data;
  }
}