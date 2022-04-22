class Promotions {
  String? id;
  String? imageUrl;
  String? name;

//<editor-fold desc="Data Methods">

  Promotions({
    this.id,
    this.imageUrl,
    this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Promotions &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ imageUrl.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Promotions{' +
        ' id: $id,' +
        ' imageUrl: $imageUrl,' +
        ' name: $name,' +
        '}';
  }

  Promotions copyWith({
    String? id,
    String? imageUrl,
    String? name,
  }) {
    return Promotions(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'imageUrl': this.imageUrl,
      'name': this.name,
    };
  }

  factory Promotions.fromMap(Map<String, dynamic> map) {
    return Promotions(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}
