import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_valk_app/screen/splash_screen.dart';
import 'package:flutter_valk_app/services/navigation_service.dart';

void main() {
  runApp(SplashScreen(key: UniqueKey(), onInitializationComplete: () {
    runApp(MainApp());
  }));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Valk",
      theme: ThemeData(
        backgroundColor: Color(0xFF4D69DD),
        scaffoldBackgroundColor: Color(0xFF4D69DD),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: Color(0xFF0A0C1F)),
      ),
      // navigatorKey: NavigationService.navigatorKey,
    );
  }
}
