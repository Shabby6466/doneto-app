part of '../r.dart';

/// this class is used to handle different api call endpoints
class ApiString {
  ApiString._();

  static String get v1 => 'v1/api';

  static String get validate => '${v1}auth/validate';

  static String get profile => '$v1/profile';

  static String get login => '$v1/auth/login/';

  static String get register => '$v1/auth/register/';

  static String get googleAuth => '$v1/auth/google/';

  static String get updateSetting => '$v1/auth/setting/';

  static String get friendsSuggestions => '$v1/friendship/suggestions';

  static String get friendRequest => '$v1/friendship/request';

  static String get block => '$v1/friendship/block';

  static String get blocked => '$v1/friendship/blocked';
}
