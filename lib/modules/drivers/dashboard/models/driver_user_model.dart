class DriverUserModel {
  String? id;
  String? firstName;
  String? userRole;
  String? emailAddress;
  String? phone;
  String? address;
  String? cnicFrontImageUrl;
  String? cnicBackImageUrl;
  String? driverLicenceImageUrl;
  String? password;
  bool? isActive;
  String? deviceTokenId;
  bool? success;
  String? errorMessage;
  String? profileImage;

//<editor-fold desc="Data Methods">

  DriverUserModel({
    this.id,
    this.firstName,
    this.userRole,
    this.emailAddress,
    this.phone,
    this.address,
    this.cnicFrontImageUrl,
    this.cnicBackImageUrl,
    this.driverLicenceImageUrl,
    this.password,
    this.isActive,
    this.success,
    this.deviceTokenId,
    this.errorMessage,
    this.profileImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriverUserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          userRole == other.userRole &&
          emailAddress == other.emailAddress &&
          phone == other.phone &&
          address == other.address &&
          cnicFrontImageUrl == other.cnicFrontImageUrl &&
          cnicBackImageUrl == other.cnicBackImageUrl &&
          driverLicenceImageUrl == other.driverLicenceImageUrl &&
          password == other.password &&
          isActive == other.isActive &&
          success == other.success &&
          deviceTokenId == other.deviceTokenId &&
          errorMessage == other.errorMessage &&
          profileImage == other.profileImage);

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      userRole.hashCode ^
      emailAddress.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      cnicFrontImageUrl.hashCode ^
      cnicBackImageUrl.hashCode ^
      driverLicenceImageUrl.hashCode ^
      password.hashCode ^
      isActive.hashCode ^
      success.hashCode ^
      deviceTokenId.hashCode ^
      errorMessage.hashCode ^
      profileImage.hashCode;

  @override
  String toString() {
    return 'DriverUserModel{' +
        ' id: $id,' +
        ' firstName: $firstName,' +
        ' userRole: $userRole,' +
        ' emailAddress: $emailAddress,' +
        ' phone: $phone,' +
        ' address: $address,' +
        ' cnicFrontImageUrl: $cnicFrontImageUrl,' +
        ' cnicBackImageUrl: $cnicBackImageUrl,' +
        ' driverLicenceImageUrl: $driverLicenceImageUrl,' +
        ' password: $password,' +
        ' isActive: $isActive,' +
        ' success: $success,' +
        ' deviceTokenId: $deviceTokenId,' +
        ' errorMessage: $errorMessage,' +
        ' profileImage: $profileImage,' +
        '}';
  }

  DriverUserModel copyWith({
    String? id,
    String? firstName,
    String? userRole,
    String? emailAddress,
    String? phone,
    String? address,
    String? cnicFrontImageUrl,
    String? cnicBackImageUrl,
    String? driverLicenceImageUrl,
    String? password,
    bool? isActive,
    bool? success,
    String? deviceTokenId,
    String? errorMessage,
    String? profileImage,
  }) {
    return DriverUserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      userRole: userRole ?? this.userRole,
      emailAddress: emailAddress ?? this.emailAddress,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cnicFrontImageUrl: cnicFrontImageUrl ?? this.cnicFrontImageUrl,
      cnicBackImageUrl: cnicBackImageUrl ?? this.cnicBackImageUrl,
      driverLicenceImageUrl:
          driverLicenceImageUrl ?? this.driverLicenceImageUrl,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      success: success ?? this.success,
      deviceTokenId: deviceTokenId ?? this.deviceTokenId,
      errorMessage: errorMessage ?? this.errorMessage,
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
      'cnicFrontImageUrl': this.cnicFrontImageUrl,
      'cnicBackImageUrl': this.cnicBackImageUrl,
      'driverLicenceImageUrl': this.driverLicenceImageUrl,
      'password': this.password,
      'isActive': this.isActive,
      'deviceTokenId': this.deviceTokenId,
      'success': this.success,
      'errorMessage': this.errorMessage,
      'profileImage': this.profileImage,
    };
  }

  factory DriverUserModel.fromMap(Map<String, dynamic> map) {
    return DriverUserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      userRole: map['userRole'] as String,
      emailAddress: map['emailAddress'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      cnicFrontImageUrl: map['cnicFrontImageUrl'] as String,
      cnicBackImageUrl: map['cnicBackImageUrl'] as String,
      driverLicenceImageUrl: map['driverLicenceImageUrl'] as String,
      isActive: map['isActive'] as bool,
      deviceTokenId: map['deviceTokenId'] as String,
      profileImage: map['profileImage'] as String,
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
    );
  }

//</editor-fold>
}
