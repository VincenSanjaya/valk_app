import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_valk_app/provider/authentication_provider.dart';
import 'package:flutter_valk_app/screen/home_screen.dart';
import 'package:flutter_valk_app/screen/login_screen.dart';

import 'package:flutter_valk_app/screen/splash_screen.dart';
import 'package:flutter_valk_app/services/navigation_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SplashScreen(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(MainApp());
      }));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (BuildContext _context) {
          return AuthenticationProvider();
        })
      ],
      child: MaterialApp(
        title: "Valk",
        theme: ThemeData(
          backgroundColor: Color(0xFF4D69DD),
          scaffoldBackgroundColor: Color(0xFF4D69DD),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Color(0xFF0A0C1F)),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext _context) => LoginScreen(),
          '/home': (BuildContext _context) => HomeScreen(),
        },
      ),
    );
  }
}
