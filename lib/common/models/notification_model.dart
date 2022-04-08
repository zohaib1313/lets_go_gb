class NotificationModel {
  String? id;
  String? fromId;
  String? toId;
  String? title;
  String? body;
  String? time;

//<editor-fold desc="Data Methods">

  NotificationModel({
    this.id,
    this.fromId,
    this.toId,
    this.title,
    this.body,
    this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fromId == other.fromId &&
          toId == other.toId &&
          title == other.title &&
          body == other.body &&
          time == other.time);

  @override
  int get hashCode =>
      id.hashCode ^
      fromId.hashCode ^
      toId.hashCode ^
      title.hashCode ^
      body.hashCode ^
      time.hashCode;

  @override
  String toString() {
    return 'NotificationModel{' +
        ' id: $id,' +
        ' fromId: $fromId,' +
        ' toId: $toId,' +
        ' title: $title,' +
        ' body: $body,' +
        ' time: $time,' +
        '}';
  }

  NotificationModel copyWith({
    String? id,
    String? fromId,
    String? toId,
    String? title,
    String? body,
    String? time,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      title: title ?? this.title,
      body: body ?? this.body,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fromId': this.fromId,
      'toId': this.toId,
      'title': this.title,
      'body': this.body,
      'time': this.time,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      fromId: map['fromId'] as String,
      toId: map['toId'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      time: map['time'] as String,
    );
  }

//</editor-fold>
}
