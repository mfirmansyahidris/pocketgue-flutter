import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  final String _kText = "text";
  final String _kLocale = "locale";

  SharedPreferences preferences;

  PrefManager(this.preferences);

  set text(String? value) => preferences.setString(_kText, value ?? "");

  String get text => preferences.getString(_kText) ?? "";

  set locale(String? value) => preferences.setString(_kLocale, value ?? "en");

  String get locale => preferences.getString(_kLocale) ?? "en";
}
