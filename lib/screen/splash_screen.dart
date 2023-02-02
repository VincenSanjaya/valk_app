import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_valk_app/services/cloud_storage_service.dart';
import 'package:flutter_valk_app/services/database_service.dart';
import 'package:flutter_valk_app/services/media_service.dart';
import 'package:flutter_valk_app/services/navigation_service.dart';
import 'package:get_it/get_it.dart';


class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashScreen({Key? key, required this.onInitializationComplete}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:1)).then((_) {
      _setup().then((_) => widget.onInitializationComplete());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Valk",
      theme: ThemeData(
        backgroundColor: Color(0xFF4D69DD),
        scaffoldBackgroundColor: Color(0xFF4D69DD),
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/valk_logo.png", width: 250, height: 250),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _regitserServices();
  }

  void _regitserServices() {
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<CloudStorageService>(CloudStorageService());
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
  }

}
