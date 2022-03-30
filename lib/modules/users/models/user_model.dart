class UserModel {
  String? id;
  String? firstName;
  String? userRole;
  String? emailAddress;
  String? phone;
  String? address;
  String? password;
  bool? isActive;
  bool? success;
  String? profileImage;
  String? errorMessage;

//<editor-fold desc="Data Methods">

  UserModel({
    this.id,
    this.firstName,
    this.userRole,
    this.emailAddress,
    this.errorMessage,
    this.phone,
    this.address,
    this.password,
    this.isActive,
    this.success,
    this.profileImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          userRole == other.userRole &&
          emailAddress == other.emailAddress &&
          phone == other.phone &&
          address == other.address &&
          password == other.password &&
          isActive == other.isActive &&
          success == other.success &&
          profileImage == other.profileImage);

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      userRole.hashCode ^
      emailAddress.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      password.hashCode ^
      isActive.hashCode ^
      success.hashCode ^
      profileImage.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' id: $id,' +
        ' firstName: $firstName,' +
        ' userRole: $userRole,' +
        ' emailAddress: $emailAddress,' +
        ' phone: $phone,' +
        ' address: $address,' +
        ' password: $password,' +
        ' isActive: $isActive,' +
        ' success: $success,' +
        ' profileImage: $profileImage,' +
        '}';
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? userRole,
    String? emailAddress,
    String? phone,
    String? address,
    String? password,
    bool? isActive,
    bool? success,
    String? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      userRole: userRole ?? this.userRole,
      emailAddress: emailAddress ?? this.emailAddress,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      success: success ?? this.success,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'userRole': this.userRole,
      'emailAddress': this.emailAddress,
      'phone': this.phone,
      'address': this.address,
      'password': this.password,
      'isActive': this.isActive,
      'success': this.success,
      'profileImage': this.profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      userRole: map['userRole'] as String,
      emailAddress: map['emailAddress'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      isActive: map['isActive'] as bool,
      success: map['success'] as bool,
      profileImage: map['profileImage'] as String,
    );
  }

//</editor-fold>
}
