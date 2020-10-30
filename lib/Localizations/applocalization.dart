import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Applocalications {
  final Locale locale;
  Applocalications(this.locale);
  static Applocalications of(BuildContext context) {
    return Localizations.of<Applocalications>(context, Applocalications);
  }

  static const LocalizationsDelegate<Applocalications> delegate =
      _AppLocalizationDelegate();
  Map<String, String> _localizedStrings;
  Future<bool> load() async {
    //load the lang json file from the lang folder
    String jsonString =
        //locale.langcode >> (en or ar )//
        await rootBundle.loadString("lang/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translation(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<Applocalications> {
  @override
  const _AppLocalizationDelegate();
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    //Include all of supported language codes
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<Applocalications> load(Locale locale) async {
    // TODO: implement load
    Applocalications localizations = new Applocalications(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Applocalications> old) {
    // TODO: implement shouldReload
    return false;
  }
}
