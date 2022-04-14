class AdminModel {
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

  AdminModel({
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
    this.errorMessage,
    this.deviceTokenId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdminModel &&
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
    return 'AdminModel{' +
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

  AdminModel copyWith({
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
    return AdminModel(
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
      'isActive': this.isActive,
      'success': this.success,
      'profileImage': this.profileImage,
      'errorMessage': this.errorMessage,
      'deviceTokenId': this.deviceTokenId,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      userRole: map['userRole'] as String,
      emailAddress: map['emailAddress'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      isActive: map['isActive'] as bool,
      success: map['success'] as bool,
      profileImage: map['profileImage'] as String,
      errorMessage: map['errorMessage'] as String,
      deviceTokenId: map['deviceTokenId'] as String,
    );
  }

//</editor-fold>
}
