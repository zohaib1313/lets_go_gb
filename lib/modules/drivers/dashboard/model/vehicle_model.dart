class VehicleModel{

  String? vehicleName;
  String? plateNo;
  String? maker;
  String? make;
  String? rentHour;
  String? mileage;
  int? seatingCapacity;
  String? transmissionType;
  bool? success;
  String? errorMessage;
  List<String>? vehicleImages;


  VehicleModel({
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
      this.vehicleImages,});



  VehicleModel.fromJson(Map<String, dynamic> map) {

      vehicleName = map['vehicleName'] ;
      plateNo =  map['plateNo'];
      maker = map['maker'];
      success = map['Success'];
      make = map['make'];
      rentHour = map['rentHour'];
      mileage = map['mileage'] ;
      seatingCapacity = map['seatingCapacity'];
      transmissionType = map['transmissionType'];

  }

  Map<String, dynamic> toMap() {
    return {
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
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      vehicleName: map['vehicleName'] as String,
      plateNo: map['plateNo'] as String,
      maker: map['maker'] as String,
      make: map['make'] as String,
      rentHour: map['rentHour'] as String,
      mileage: map['mileage'] as String,
      seatingCapacity: map['seatingCapacity'] as int,
      transmissionType: map['transmissionType'] as String,
      success: map['success'] as bool,
      errorMessage: map['errorMessage'] as String,
      vehicleImages: map['vehicleImages'] as List<String>,
    );
  }
}