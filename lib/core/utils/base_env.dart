// coverage: false
// coverage:ignore-file

import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseEnv {
  BaseEnv._internal();

  static final BaseEnv _instance = BaseEnv._internal();

  static BaseEnv get instance => _instance;

  late String _url;
  late String _agoraAppID;
  late String _tempToken;
  late String _channel;
  late String _expoPublicSupabaseUrl;
  late String _expoPublicSupabaseAnonKey;
  late String _androidFirebaseApiKey;
  late String _androidFirebaseMessageId;
  late String _androidFirebaseAppId;
  late String _androidFirebaseProjectId;

  void setEnv() {
    _url = dotenv.env['BASE_URL'] ?? '';
    _agoraAppID = dotenv.env['AGORA_APP_ID'] ?? '';
    _tempToken = dotenv.env['TEMP_TOKEN'] ?? '';
    _channel = dotenv.env['CHANNEL'] ?? '';
    _expoPublicSupabaseUrl = dotenv.env['EXPO_PUBLIC_SUPABASE_URL'] ?? '';
    _expoPublicSupabaseAnonKey = dotenv.env['EXPO_PUBLIC_SUPABASE_ANON_KEY'] ?? '';
    _androidFirebaseApiKey = dotenv.env['ANDROID_FIREBASE_API_KEY'] ?? '';
    _androidFirebaseAppId = dotenv.env['ANDROID_FIREBASE_APP_ID'] ?? '';
    _androidFirebaseMessageId = dotenv.env['ANDROID_FIREBASE_MESSAGE_ID'] ?? '';
    _androidFirebaseProjectId = dotenv.env['ANDROID_FIREBASE_PROJECT_ID'] ?? '';
  }

  String get url => _url;

  String get expoPublicSupabaseUrl => _expoPublicSupabaseUrl;

  String get expoPublicSupabaseAnonKey => _expoPublicSupabaseAnonKey;

  String get agoraAppID => _agoraAppID;

  String get channel => _channel;

  String get tempToken => _tempToken;

  String get androidFirebaseApiKey => _androidFirebaseApiKey;

  String get androidFirebaseAppId => _androidFirebaseAppId;

  String get androidFirebaseMessageId => _androidFirebaseMessageId;

  String get androidFirebaseProjectId => _androidFirebaseProjectId;
}
