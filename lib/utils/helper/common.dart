// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketgue/config/config.dart';
import 'package:pocketgue/ui/ui.dart';

void logs(dynamic message) {
  debugPrint(
    "========================================================================================",
  );
  debugPrint("| Message Log : $message");
  debugPrint(
    "========================================================================================",
  );
}

void logsJson(dynamic message) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final String prettyJson = encoder.convert(message);
  debugPrint(
    "========================================================================================",
  );
  debugPrint("| Message Log : $prettyJson");
  debugPrint(
    "========================================================================================",
  );
}

//register locale with json file
Map<String, String> get mapLocale => const {
  'en': 'locales/en.json',
};

Future<void> setLocale(String locale) async {
  /// Get selected locales
  sl<PrefManager>().locale = locale;

  final String _locale = sl<PrefManager>().locale;
  logs("Locale $_locale");
  final String _path = mapLocale[_locale]!;
  final String _jsonLocale = await rootBundle.loadString(_path);

  /// Update language
  sl<PrefManager>().text = _jsonLocale;
  Strings.clear();
}

Duration durationDefault = const Duration(milliseconds: 300);