class BookingModel {
  String? id;
  String? pickUpDate;
  String? transactionId;
  String? vehicleId;
  String? userId;
  String? pickUpTime;
  DateTime? bookingDateStart;
  DateTime? bookingDateEnd;
  String? pickUpAddress;
  String? bookingNotes;
  int? passengers;
  num? totalAmount;
  num? twentyPercentAmount;
  double? pickUpLat;
  double? pickUpLng;
  String? status;
  String? bookingId;

//<editor-fold desc="Data Methods">

  BookingModel({
    this.id,
    this.pickUpDate,
    this.transactionId,
    this.vehicleId,
    this.userId,
    this.pickUpTime,
    this.bookingDateStart,
    this.bookingDateEnd,
    this.pickUpAddress,
    this.bookingNotes,
    this.passengers,
    this.totalAmount,
    this.twentyPercentAmount,
    this.pickUpLat,
    this.pickUpLng,
    this.status,
    this.bookingId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookingModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pickUpDate == other.pickUpDate &&
          transactionId == other.transactionId &&
          vehicleId == other.vehicleId &&
          userId == other.userId &&
          pickUpTime == other.pickUpTime &&
          bookingDateStart == other.bookingDateStart &&
          bookingDateEnd == other.bookingDateEnd &&
          pickUpAddress == other.pickUpAddress &&
          bookingNotes == other.bookingNotes &&
          passengers == other.passengers &&
          totalAmount == other.totalAmount &&
          twentyPercentAmount == other.twentyPercentAmount &&
          pickUpLat == other.pickUpLat &&
          pickUpLng == other.pickUpLng &&
          status == other.status &&
          bookingId == other.bookingId);

  @override
  int get hashCode =>
      id.hashCode ^
      pickUpDate.hashCode ^
      transactionId.hashCode ^
      vehicleId.hashCode ^
      userId.hashCode ^
      pickUpTime.hashCode ^
      bookingDateStart.hashCode ^
      bookingDateEnd.hashCode ^
      pickUpAddress.hashCode ^
      bookingNotes.hashCode ^
      passengers.hashCode ^
      totalAmount.hashCode ^
      twentyPercentAmount.hashCode ^
      pickUpLat.hashCode ^
      pickUpLng.hashCode ^
      status.hashCode ^
      bookingId.hashCode;

  @override
  String toString() {
    return 'BookingModel{' +
        ' id: $id,' +
        ' pickUpDate: $pickUpDate,' +
        ' transactionId: $transactionId,' +
        ' vehicleId: $vehicleId,' +
        ' userId: $userId,' +
        ' pickUpTime: $pickUpTime,' +
        ' bookingDateStart: $bookingDateStart,' +
        ' bookingDateEnd: $bookingDateEnd,' +
        ' pickUpAddress: $pickUpAddress,' +
        ' bookingNotes: $bookingNotes,' +
        ' passengers: $passengers,' +
        ' totalAmount: $totalAmount,' +
        ' twentyPercentAmount: $twentyPercentAmount,' +
        ' pickUpLat: $pickUpLat,' +
        ' pickUpLng: $pickUpLng,' +
        ' status: $status,' +
        ' bookingId: $bookingId,' +
        '}';
  }

  BookingModel copyWith({
    String? id,
    String? pickUpDate,
    String? transactionId,
    String? vehicleId,
    String? userId,
    String? pickUpTime,
    DateTime? bookingDateStart,
    DateTime? bookingDateEnd,
    String? pickUpAddress,
    String? bookingNotes,
    int? passengers,
    num? totalAmount,
    num? twentyPercentAmount,
    double? pickUpLat,
    double? pickUpLng,
    String? status,
    String? bookingId,
  }) {
    return BookingModel(
      id: id ?? this.id,
      pickUpDate: pickUpDate ?? this.pickUpDate,
      transactionId: transactionId ?? this.transactionId,
      vehicleId: vehicleId ?? this.vehicleId,
      userId: userId ?? this.userId,
      pickUpTime: pickUpTime ?? this.pickUpTime,
      bookingDateStart: bookingDateStart ?? this.bookingDateStart,
      bookingDateEnd: bookingDateEnd ?? this.bookingDateEnd,
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      bookingNotes: bookingNotes ?? this.bookingNotes,
      passengers: passengers ?? this.passengers,
      totalAmount: totalAmount ?? this.totalAmount,
      twentyPercentAmount: twentyPercentAmount ?? this.twentyPercentAmount,
      pickUpLat: pickUpLat ?? this.pickUpLat,
      pickUpLng: pickUpLng ?? this.pickUpLng,
      status: status ?? this.status,
      bookingId: bookingId ?? this.bookingId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'pickUpDate': this.pickUpDate,
      'transactionId': this.transactionId,
      'vehicleId': this.vehicleId,
      'userId': this.userId,
      'pickUpTime': this.pickUpTime,
      'bookingDateStart': this.bookingDateStart,
      'bookingDateEnd': this.bookingDateEnd,
      'pickUpAddress': this.pickUpAddress,
      'bookingNotes': this.bookingNotes,
      'passengers': this.passengers,
      'totalAmount': this.totalAmount,
      'twentyPercentAmount': this.twentyPercentAmount,
      'pickUpLat': this.pickUpLat,
      'pickUpLng': this.pickUpLng,
      'status': this.status,
      'bookingId': this.bookingId,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String,
      pickUpDate: map['pickUpDate'] as String,
      transactionId: map['transactionId'] as String,
      vehicleId: map['vehicleId'] as String,
      userId: map['userId'] as String,
      pickUpTime: map['pickUpTime'] as String,
      bookingDateStart: map['bookingDateStart'].toDate(),
      bookingDateEnd: map['bookingDateEnd'].toDate(),
      pickUpAddress: map['pickUpAddress'] as String,
      bookingNotes: map['bookingNotes'] as String,
      passengers: map['passengers'] as int,
      totalAmount: map['totalAmount'] as num,
      twentyPercentAmount: map['twentyPercentAmount'] as num,
      pickUpLat: map['pickUpLat'] as double,
      pickUpLng: map['pickUpLng'] as double,
      status: map['status'] as String,
      bookingId: map['bookingId'] as String,
    );
  }

//</editor-fold>
}
