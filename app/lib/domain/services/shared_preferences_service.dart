import 'dart:convert';

import 'package:openvibe_app/domain/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();

  static final SharedPreferencesService _instance =
      SharedPreferencesService._();

  static late final SharedPreferences _sharedPreferences;

  factory SharedPreferencesService() {
    return _instance;
  }

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveMessage(Message message) async {
    _sharedPreferences.setString(message.id, jsonEncode(message.toJson()));
  }

  static Future<Message?> getMessage(String id) async {
    final messageJson = _sharedPreferences.getString(id);
    if (messageJson == null) {
      return null;
    }
    return Message.fromJson(jsonDecode(messageJson) as Map<String, dynamic>);
  }

  static void clearMessagesCache() {
    _sharedPreferences.clear();
  }
}
