class Dropdown {
  int? id;
  int? longId;
  String? stringId;
  String? name;
  Dropdown({this.id, this.name, this.longId, this.stringId});

  Dropdown.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    longId = json['LongId'];
    stringId = json['StringId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['LongId'] = longId;
    data['StringId'] = stringId;
    return data;
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(Dropdown? model) {
    return stringId == model?.stringId;
  }
}
