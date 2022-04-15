class BlogModel {
  String? id;
  String? placeName;
  String? placeAddress;
  String? placeDescription;
  List<dynamic>? placeImages;
  List<dynamic>? placeFeatures;

//<editor-fold desc="Data Methods">

  BlogModel({
    this.id,
    this.placeName,
    this.placeAddress,
    this.placeDescription,
    this.placeImages,
    this.placeFeatures,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlogModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          placeName == other.placeName &&
          placeAddress == other.placeAddress &&
          placeDescription == other.placeDescription &&
          placeImages == other.placeImages &&
          placeFeatures == other.placeFeatures);

  @override
  int get hashCode =>
      id.hashCode ^
      placeName.hashCode ^
      placeAddress.hashCode ^
      placeDescription.hashCode ^
      placeImages.hashCode ^
      placeFeatures.hashCode;

  @override
  String toString() {
    return 'BlogModel{' +
        ' id: $id,' +
        ' placeName: $placeName,' +
        ' placeAddress: $placeAddress,' +
        ' placeDescription: $placeDescription,' +
        ' placeImages: $placeImages,' +
        ' placeFeatures: $placeFeatures,' +
        '}';
  }

  BlogModel copyWith({
    String? id,
    String? placeName,
    String? placeAddress,
    String? placeDescription,
    List<dynamic>? placeImages,
    List<dynamic>? placeFeatures,
  }) {
    return BlogModel(
      id: id ?? this.id,
      placeName: placeName ?? this.placeName,
      placeAddress: placeAddress ?? this.placeAddress,
      placeDescription: placeDescription ?? this.placeDescription,
      placeImages: placeImages ?? this.placeImages,
      placeFeatures: placeFeatures ?? this.placeFeatures,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'placeName': this.placeName,
      'placeAddress': this.placeAddress,
      'placeDescription': this.placeDescription,
      'placeImages': this.placeImages,
      'placeFeatures': this.placeFeatures,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      placeName: map['placeName'] as String,
      placeAddress: map['placeAddress'] as String,
      placeDescription: map['placeDescription'] as String,
      placeImages: map['placeImages'] as List<dynamic>,
      placeFeatures: map['placeFeatures'] as List<dynamic>,
    );
  }

//</editor-fold>
}
