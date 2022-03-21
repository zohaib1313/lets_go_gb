class UserModel {
  String? id;
  String? adminId;
  String? firstName;
  String? lastName;
  String? userRole;
  String? emailAddress;
  String? phone;
  String? profileImageUrl;
  String? password;
  String? confirmPassword;
  bool? success;
  String? errorMessage;

  UserModel(
      {this.id,
      this.adminId,
      this.emailAddress,
      this.password,
      this.confirmPassword,
      this.firstName,
      this.lastName,
      this.userRole,
      this.phone,
      this.profileImageUrl,
      this.success,
      this.errorMessage});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    id = json['Id'];
    adminId = json['AdminId'];
    emailAddress = json['EmailAddress'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userRole = json['UserRole'];
    phone = json['Phone'];
    profileImageUrl = json['ProfileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Id'] = id;
    data['AdminId'] = adminId;
    data['EmailAddress'] = emailAddress;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['UserRole'] = userRole;
    data['Phone'] = phone;
    data['ProfileUrl'] = profileImageUrl;
    return data;
  }
}
