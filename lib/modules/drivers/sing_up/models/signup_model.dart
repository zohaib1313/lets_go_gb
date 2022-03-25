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
  bool? success;
  num? ratings;
  String? errorMessage;
  String? profileImage;

//<editor-fold desc="Data Methods">

  DriverUserModel({
    this.id,
    this.firstName,
    this.userRole,
    this.emailAddress,
    this.phone,
    this.ratings,
    this.profileImage,
    this.address,
    this.cnicFrontImageUrl,
    this.cnicBackImageUrl,
    this.driverLicenceImageUrl,
    this.password,
    this.isActive,
    this.success,
    this.errorMessage,
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
          ratings == other.ratings &&
          address == other.address &&
          cnicFrontImageUrl == other.cnicFrontImageUrl &&
          cnicBackImageUrl == other.cnicBackImageUrl &&
          driverLicenceImageUrl == other.driverLicenceImageUrl &&
          password == other.password &&
          isActive == other.isActive &&
          success == other.success &&
          profileImage == other.profileImage &&
          errorMessage == other.errorMessage);

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
      profileImage.hashCode ^
      isActive.hashCode ^
      success.hashCode ^
      ratings.hashCode ^
      errorMessage.hashCode;

  @override
  String toString() {
    return 'SignUpModel{' +
        ' id: $id,' +
        ' firstName: $firstName,' +
        ' userRole: $userRole,' +
        ' emailAddress: $emailAddress,' +
        ' phone: $phone,' +
        ' address: $address,' +
        ' cnicFrontImageUrl: $cnicFrontImageUrl,' +
        ' cnicBackImageUrl: $cnicBackImageUrl,' +
        ' driverLicenceImageUrl: $driverLicenceImageUrl,' +
        ' profileImage: $profileImage,' +
        ' password: $password,' +
        ' isActive: $isActive,' +
        ' success: $success,' +
        ' ratings: $ratings,' +
        ' errorMessage: $errorMessage,' +
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
    String? profileImage,
    num? ratings,
    bool? success,
    String? errorMessage,
  }) {
    return DriverUserModel(
      id: id ?? this.id,
      ratings: ratings ?? this.ratings,
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
      profileImage: profileImage ?? this.profileImage,
      errorMessage: errorMessage ?? this.errorMessage,
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
      'isActive': this.isActive,
      'success': this.success,
      'ratings': this.ratings,
      'profileImage': this.profileImage,
      'errorMessage': this.errorMessage,
    };
  }

  factory DriverUserModel.fromMap(Map<String, dynamic> map) {
    return DriverUserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      userRole: map['userRole'] as String,
      emailAddress: map['emailAddress'] as String,
      phone: map['phone'] as String,
      ratings: map['ratings'] as num,
      profileImage: map['profileImage'] as String,
      address: map['address'] as String,
      cnicFrontImageUrl: map['cnicFrontImageUrl'] as String,
      cnicBackImageUrl: map['cnicBackImageUrl'] as String,
      driverLicenceImageUrl: map['driverLicenceImageUrl'] as String,
      isActive: map['isActive'] as bool,
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
    );
  }

//</editor-fold>
}
