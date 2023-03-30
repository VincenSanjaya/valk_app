import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_valk_app/widgets/rounded_image.dart';
import 'package:get_it/get_it.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/media_service.dart';
import '../services/database_service.dart';
import '../services/cloud_storage_service.dart';

import '../services/navigation_service.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';

import '../provider/authentication_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  late NavigationService _navigation;
  String? _email;
  String? _name;
  String? _password;

  PlatformFile? _profileImage;
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.06, vertical: _deviceHeight * 0.02),
        height: _deviceHeight * 0.98,
        width: _deviceWidth,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            _profileImageField(),
            Gap(_deviceHeight * 0.03),
            _registerForm(),
            Gap(_deviceHeight * 0.03),
            _registerButton(),
            Expanded(
              child: Container(),
            ),
            _loginAccountLink()
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(onTap: () {
      GetIt.instance.get<MediaService>().pickImageFromLibrary().then((_file) {
        (_file) {
          setState(() {
            _profileImage = _file;
          });
        };
      });
    }, child: () {
      if (_profileImage != null) {
        return RoundedImageFile(
            key: UniqueKey(),
            image: _profileImage!,
            size: _deviceHeight * 0.15);
      } else {
        return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath: "https://i.pravatar.cc/1000?img=65",
            size: _deviceHeight * 0.15);
      }
    }());
  }

  Widget _registerForm() {
    return Container(
      height: _deviceHeight * 0.25,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _name = _value;
                  });
                },
                hintText: "Enter Name",
                obscureText: false,
                regEx: r'.{8,}'),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _email = _value;
                  });
                },
                hintText: "Enter Email",
                obscureText: false,
                regEx: r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$'),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                hintText: "Enter Password",
                obscureText: true,
                regEx: r'.{8,}'),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
        name: "Register",
        onPressed: () async {},
        height: _deviceHeight * 0.065,
        width: _deviceWidth);
  }

  Widget _loginAccountLink() {
    return GestureDetector(
        onTap: () => _navigation.navigateToRoute("/login"),
        child: Container(
            child: Text(
              "Already have an account? Login!",
              style: GoogleFonts.poppins(fontSize: 18, color: Color(0xFF202023)),
            )));
  }

}
