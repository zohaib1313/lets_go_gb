class ReviewModel {
  String? id;
  String? reviewMessage;
  String? userId;
  String? driverId;
  String? bookingId;
  String? dateTime;
  double? ratings = 0.0;

//<editor-fold desc="Data Methods">

  ReviewModel({
    this.id,
    this.reviewMessage,
    this.userId,
    this.driverId,
    this.bookingId,
    this.dateTime,
    this.ratings = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          reviewMessage == other.reviewMessage &&
          userId == other.userId &&
          driverId == other.driverId &&
          bookingId == other.bookingId &&
          dateTime == other.dateTime &&
          ratings == other.ratings);

  @override
  int get hashCode =>
      id.hashCode ^
      reviewMessage.hashCode ^
      userId.hashCode ^
      driverId.hashCode ^
      bookingId.hashCode ^
      dateTime.hashCode ^
      ratings.hashCode;

  @override
  String toString() {
    return 'ReviewModel{' +
        ' id: $id,' +
        ' reviewMessage: $reviewMessage,' +
        ' userId: $userId,' +
        ' driverId: $driverId,' +
        ' bookingId: $bookingId,' +
        ' dateTime: $dateTime,' +
        ' ratings: $ratings,' +
        '}';
  }

  ReviewModel copyWith({
    String? id,
    String? reviewMessage,
    String? userId,
    String? driverId,
    String? bookingId,
    String? dateTime,
    double? ratings,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      reviewMessage: reviewMessage ?? this.reviewMessage,
      userId: userId ?? this.userId,
      driverId: driverId ?? this.driverId,
      bookingId: bookingId ?? this.bookingId,
      dateTime: dateTime ?? this.dateTime,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'reviewMessage': this.reviewMessage,
      'userId': this.userId,
      'driverId': this.driverId,
      'bookingId': this.bookingId,
      'dateTime': this.dateTime,
      'ratings': this.ratings,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] as String,
      reviewMessage: map['reviewMessage'] as String,
      userId: map['userId'] as String,
      driverId: map['driverId'] as String,
      bookingId: map['bookingId'] as String,
      dateTime: map['dateTime'] as String,
      ratings: map['ratings'] as double,
    );
  }

//</editor-fold>
}
