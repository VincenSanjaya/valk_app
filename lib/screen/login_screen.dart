import 'package:flutter/material.dart';
import 'package:flutter_valk_app/provider/authentication_provider.dart';
import 'package:flutter_valk_app/widgets/custom_input_field.dart';
import 'package:flutter_valk_app/widgets/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_valk_app/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.06, vertical: _deviceHeight * 0.05),
      height: _deviceHeight * 0.98,
      width: _deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(),
          ),
          _pageTitle(),
          SizedBox(
            height: _deviceHeight * 0.04,
          ),
          _loginFrom(),
          SizedBox(
            height: _deviceHeight * 0.04,
          ),
          _loginButton(),
          Expanded(
            child: Container(),
          ),
          _registerAccountLink(),
        ],
      ),
    ));
  }

  Widget _pageTitle() {
    return Container(
        height: _deviceHeight * 0.10,
        child: Text("Valk",
            style: GoogleFonts.poppins(
                fontSize: 50,
                color: Color(0xFF202023),
                letterSpacing: 5,
                fontWeight: FontWeight.bold)));
  }

  Widget _loginFrom() {
    return Container(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              hintText: "Enter your email",
              obscureText: false,
              regEx: r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
            ),
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              hintText: "Enter your Password",
              obscureText: true,
              regEx: r".{8,}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
        name: "Login",
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            _auth.loginUsingEmailAndPassword(_email!, _password!);

          }
        },
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.85);
  }

  Widget _registerAccountLink() {
    return GestureDetector(
        onTap: () => _navigation.navigateToRoute("/register"),
        child: Container(
            child: Text(
          "Don't have an account? Register!",
          style: GoogleFonts.poppins(fontSize: 18, color: Color(0xFF202023)),
        )));
  }
}
