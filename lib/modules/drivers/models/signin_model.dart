class SignInModel {
  String? token;
  User? user;

  SignInModel({this.token, this.user});

  SignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'SignInModel{token: $token, user: $user}';
  }
}

class User {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? emailVerifiedAt;
  String? utype;
  String? otp;
  int? verified;
  String? phoneVerifiedAt;
  String? verification;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? profile;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.profile,
      this.lastName,
      this.email,
      this.mobile,
      this.emailVerifiedAt,
      this.utype,
      this.otp,
      this.verified,
      this.phoneVerifiedAt,
      this.verification,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    utype = json['utype'];
    otp = json['otp'];
    profile = json['profile'];
    verified = json['verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    verification = json['verification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['utype'] = this.utype;
    data['otp'] = this.otp;
    data['profile'] = this.profile;
    data['verified'] = this.verified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['verification'] = this.verification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, emailVerifiedAt: $emailVerifiedAt, utype: $utype, otp: $otp, verified: $verified, phoneVerifiedAt: $phoneVerifiedAt, verification: $verification, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt}';
  }
}
