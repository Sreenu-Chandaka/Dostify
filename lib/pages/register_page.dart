//Packages
// ignore_for_file: unused_element


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';

//Services
import '../services/navigation_service.dart';

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
  PlatformFile? _profileImage;
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
        onTap: () {
          FilePicker.platform;
        },
        child: () {
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
}
