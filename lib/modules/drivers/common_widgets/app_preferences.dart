import 'package:get_storage/get_storage.dart';

const String _userCredentialsId = "userCredentialsId";
const String _userRole = "userRole";

class AppPreferences {

  /// set User credentials id
  static setUserCredentialsId(String value) => GetStorage().write(_userCredentialsId, value);
  /// get User credentials id
  static get getUserCredentialsId  => GetStorage().read<String>(_userCredentialsId);
  /// remove User credentials id
  static removeUserCredentialsId() => GetStorage().remove(_userCredentialsId);

  /// set User Role
  static setUserRole(String value) => GetStorage().write(_userRole, value);
  /// get User Role
  static get getUserRole  => GetStorage().read<String>(_userRole);
  /// remove User Role
  static removeUserRole() => GetStorage().remove(_userRole);

}