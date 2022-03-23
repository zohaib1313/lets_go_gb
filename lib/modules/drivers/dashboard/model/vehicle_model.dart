class VehicleModel {
  String? id;
  String? vehicleName;
  String? plateNo;
  String? maker;
  String? make;
  String? rentHour;
  String? mileage;
  String? seatingCapacity;
  String? transmissionType;
  bool? success;
  String? errorMessage;
  List<String>? vehicleImages;
  List<String>? features;
  String? descriptionNote;

  VehicleModel({
    this.id,
    this.vehicleName,
    this.plateNo,
    this.maker,
    this.make,
    this.rentHour,
    this.mileage,
    this.seatingCapacity,
    this.transmissionType,
    this.success,
    this.errorMessage,
    this.vehicleImages,
    this.features,
    this.descriptionNote,

  });

  VehicleModel.fromJson(Map<String, dynamic> map) {
    id = map["Id"];
    vehicleName = map['vehicleName'];
    plateNo = map['plateNo'];
    maker = map['maker'];
    success = map['success'];
    make = map['make'];
    rentHour = map['rentHour'];
    mileage = map['mileage'];
    seatingCapacity = map['seatingCapacity'];
    transmissionType = map['transmissionType'];
    vehicleImages = map['vehicleImages'];
    descriptionNote = map["DescriptionNote"];
    features = map['Feature'];

  }

  Map<String, dynamic> toMap() {
    return {
      'Id':id,
      'vehicleName': vehicleName,
      'plateNo': plateNo,
      'maker': maker,
      'make': make,
      'rentHour': rentHour,
      'mileage': mileage,
      'seatingCapacity': seatingCapacity,
      'transmissionType': transmissionType,
      'success': success,
      'errorMessage': errorMessage,
      'vehicleImages': vehicleImages,
      'DescriptionNote' : descriptionNote,
      'Feature': features,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['Id'] as String,
      vehicleName: map['vehicleName'] as String,
      plateNo: map['plateNo'] as String,
      maker: map['maker'] as String,
      make: map['make'] as String,
      rentHour: map['rentHour'] as String,
      mileage: map['mileage'] as String,
      seatingCapacity: map['seatingCapacity'] as String,
      transmissionType: map['transmissionType'] as String,
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
      vehicleImages: map['vehicleImages'] as List<String>,
      features:  map['Feature'] as List<String>,
      descriptionNote:  map['DescriptionNote'] as String,
    );
  }

  @override
  String toString() {
    return 'VehicleModel{vehicleName: $vehicleName, plateNo: $plateNo, maker: $maker, make: $make, rentHour: $rentHour, mileage: $mileage, seatingCapacity: $seatingCapacity, transmissionType: $transmissionType, success: $success, errorMessage: $errorMessage, vehicleImages: $vehicleImages}';
  }
}
