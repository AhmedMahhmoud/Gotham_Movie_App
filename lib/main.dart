import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/Views/Main_Screen.dart';
import 'package:movies_app/Widgets/movies_wheel.dart';
import 'Localizations/applocalization.dart';
import 'Views/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Montserrat",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: [Locale("en", "US"), Locale("ar", "EG")],
      //localization delegate makes sure that the localization data for the propper langugage is loaded !//
      localizationsDelegates: [
//APP LOCALIZATION DELGATE CLASS is responsible for loading the translations from JSON FILE/
        Applocalications.delegate,
        //GLOBAL delegate is build in localization of basic texts like alarms and cancel buttons
        GlobalMaterialLocalizations.delegate,
        //build in for text direction LTR/RTL//
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (localee, supportedLocales) {
        //Check if the current device locale is suported//
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == localee.languageCode &&
              supportedLocale.countryCode == localee.countryCode) {
            return supportedLocale;
          }
        }
        //RETURN THE DEFAULT LOCALE IF NOT SUPPORTED LOCALE IS CHOSEN
        return supportedLocales.first;
      },
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MainScreen(),
      )//Home(),
  
    );
  }
}
