//Packages

// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dostify/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';

//Services
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';

//Widgets
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_image.dart';

//Providers
import '../providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _registerFormKey = GlobalKey<FormState>();

  PlatformFile? _profileImage;
  String? _email;
  String? _name;
  String? _password;

  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorage;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
        width: _deviceWidth * 0.98,
        height: _deviceHeight * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageField(),
            SizedBox(height: _deviceHeight * 0.05),
            _registerForm(),
            SizedBox(height: _deviceHeight * 0.05),
            _registerButton()
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(onTap: () {
      GetIt.instance.get<MediaService>().pickImageFromLibrary().then((_file) {
        setState(() {
          _profileImage = _file;
        });
      });
    }, child: () {
      if (_profileImage != null) {
        return RoundedImageFile(
            key: UniqueKey(),
            size: _deviceHeight * 0.15,
            image: _profileImage!);
      }
      return RoundedImageNetwork(
        imagePath: 'https://i.pravatar.cc/1000?img=3',
        size: _deviceHeight * 0.15,
        key: UniqueKey(),
      );
    }());
  }

  Widget _registerForm() {
    return SizedBox(
      height: _deviceHeight * 0.35,
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
                  regEx: r".{8,}",
                  hintText: "Name",
                  obscureText: false),
              CustomTextFormField(
                  onSaved: (_value) {
                    setState(() {
                      _email = _value;
                    });
                  },
                  regEx:
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  hintText: "Email",
                  obscureText: false),
              CustomTextFormField(
                  onSaved: (_value) {
                    setState(() {
                      _password = _value;
                    });
                  },
                  regEx: r".{8,}",
                  hintText: "Password",
                  obscureText: true)
            ],
          )),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_registerFormKey.currentState!.validate() &&
            _profileImage != null) {
          _registerFormKey.currentState!.save();
          String? _uid = await _auth.registerUserUsingEmailAndPassword(
              _email!,_password!);
          String? imageURL =
              await _cloudStorage.saveUserImageToStorage(_uid, _profileImage!);

          await _db.createUser(
              _uid!, _email!,_name!,imageURL!);
          await _auth.logout();
          await _auth.loginUsingEmailAndPassword(_email!,_password!);
        }
      },
    );
  }
}
