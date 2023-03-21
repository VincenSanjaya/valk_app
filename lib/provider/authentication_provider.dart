import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../models/chat_users.dart';
import '../services/navigation_service.dart';
import '../services/database_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    _auth.authStateChanges().listen((_user) {
      if(_user != null) {
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then((_snapshot) {
          Map<String, dynamic> _userData = _snapshot.data()! as Map<String, dynamic>;
          user = ChatUser.fromJSON({
            "uid": _user.uid,
            "name": _userData["name"],
            "email": _userData["email"],
            "last_active": _userData["last_active"],
            "image": _userData["image"],
          });
          _navigationService.removeAndNavigateToRoute('/home');
        });
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }});
  }



  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException {
      print("Error logging in with email and password");
    } catch (e) {
      print(e);
    }
  }
}
