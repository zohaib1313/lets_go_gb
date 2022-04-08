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
  String? deviceTokenId;

//<editor-fold desc="Data Methods">

  UserModel({
    this.id,
    this.firstName,
    this.userRole,
    this.emailAddress,
    this.phone,
    this.address,
    this.password,
    this.isActive,
    this.success,
    this.profileImage,
    this.errorMessage = 'Something went wrong',
    this.deviceTokenId,
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
          profileImage == other.profileImage &&
          errorMessage == other.errorMessage &&
          deviceTokenId == other.deviceTokenId);

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
      profileImage.hashCode ^
      errorMessage.hashCode ^
      deviceTokenId.hashCode;

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
        ' errorMessage: $errorMessage,' +
        ' deviceTokenId: $deviceTokenId,' +
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
    String? errorMessage,
    String? deviceTokenId,
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
      errorMessage: errorMessage ?? this.errorMessage,
      deviceTokenId: deviceTokenId ?? this.deviceTokenId,
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
      'profileImage': this.profileImage,
      'success': this.success,
      'errorMessage': this.errorMessage,
      'deviceTokenId': this.deviceTokenId,
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
      isActive: map['isActive'] as bool,
      profileImage: map['profileImage'] as String,
      deviceTokenId: map['deviceTokenId'] as String,
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
    );
  }

//</editor-fold>
}
