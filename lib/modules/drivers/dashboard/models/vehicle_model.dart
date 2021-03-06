class VehicleModel {
  String? id;
  String? vehicleName;
  String? plateNo;
  String? maker;
  String? make;
  String? rent;
  String? mileage;
  String? seatingCapacity;
  String? transmissionType;
  bool? success;
  String? errorMessage;
  List<dynamic>? vehicleImages;
  List<dynamic>? features;
  String? descriptionNote;

//<editor-fold desc="Data Methods">

  VehicleModel({
    this.id,
    this.vehicleName,
    this.plateNo,
    this.maker,
    this.make,
    this.rent,
    this.mileage,
    this.seatingCapacity,
    this.transmissionType,
    this.success,
    this.errorMessage,
    this.vehicleImages,
    this.features,
    this.descriptionNote,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          vehicleName == other.vehicleName &&
          plateNo == other.plateNo &&
          maker == other.maker &&
          make == other.make &&
          rent == other.rent &&
          mileage == other.mileage &&
          seatingCapacity == other.seatingCapacity &&
          transmissionType == other.transmissionType &&
          success == other.success &&
          errorMessage == other.errorMessage &&
          vehicleImages == other.vehicleImages &&
          features == other.features &&
          descriptionNote == other.descriptionNote);

  @override
  int get hashCode =>
      id.hashCode ^
      vehicleName.hashCode ^
      plateNo.hashCode ^
      maker.hashCode ^
      make.hashCode ^
      rent.hashCode ^
      mileage.hashCode ^
      seatingCapacity.hashCode ^
      transmissionType.hashCode ^
      success.hashCode ^
      errorMessage.hashCode ^
      vehicleImages.hashCode ^
      features.hashCode ^
      descriptionNote.hashCode;

  @override
  String toString() {
    return 'VehicleModel{' +
        ' id: $id,' +
        ' vehicleName: $vehicleName,' +
        ' plateNo: $plateNo,' +
        ' maker: $maker,' +
        ' make: $make,' +
        ' rent: $rent,' +
        ' mileage: $mileage,' +
        ' seatingCapacity: $seatingCapacity,' +
        ' transmissionType: $transmissionType,' +
        ' success: $success,' +
        ' errorMessage: $errorMessage,' +
        ' vehicleImages: $vehicleImages,' +
        ' features: $features,' +
        ' descriptionNote: $descriptionNote,' +
        '}';
  }

  VehicleModel copyWith({
    String? id,
    String? vehicleName,
    String? plateNo,
    String? maker,
    String? make,
    String? rent,
    String? mileage,
    String? seatingCapacity,
    String? transmissionType,
    bool? success,
    String? errorMessage,
    List<dynamic>? vehicleImages,
    List<dynamic>? features,
    String? descriptionNote,
    double? ratings,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      vehicleName: vehicleName ?? this.vehicleName,
      plateNo: plateNo ?? this.plateNo,
      maker: maker ?? this.maker,
      make: make ?? this.make,
      rent: rent ?? this.rent,
      mileage: mileage ?? this.mileage,
      seatingCapacity: seatingCapacity ?? this.seatingCapacity,
      transmissionType: transmissionType ?? this.transmissionType,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      vehicleImages: vehicleImages ?? this.vehicleImages,
      features: features ?? this.features,
      descriptionNote: descriptionNote ?? this.descriptionNote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'vehicleName': this.vehicleName,
      'plateNo': this.plateNo,
      'maker': this.maker,
      'make': this.make,
      'rent': this.rent,
      'mileage': this.mileage,
      'seatingCapacity': this.seatingCapacity,
      'transmissionType': this.transmissionType,
      'success': this.success,
      'errorMessage': this.errorMessage,
      'vehicleImages': this.vehicleImages,
      'features': this.features,
      'descriptionNote': this.descriptionNote,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id'] as String,
      vehicleName: map['vehicleName'] as String,
      plateNo: map['plateNo'] as String,
      maker: map['maker'] as String,
      make: map['make'] as String,
      rent: map['rent'] as String,
      mileage: map['mileage'] as String,
      seatingCapacity: map['seatingCapacity'] as String,
      transmissionType: map['transmissionType'] as String,
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
      vehicleImages: map['vehicleImages'] as List<dynamic>,
      features: map['features'] as List<dynamic>,
      descriptionNote: map['descriptionNote'] as String,
    );
  }

//</editor-fold>
}
