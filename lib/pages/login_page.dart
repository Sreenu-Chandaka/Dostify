//Packages
import 'package:flutter/material.dart';
import "package:get_it/get_it.dart";
import "package:provider/provider.dart";

//Widgets
import "../widgets/custom_input_field.dart";
import "../widgets/rounded_button.dart";

//Services
import "../providers/authentication_provider.dart";
import "../services/navigation_service.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  double _deviceHeight = 0;
  double _deviceWidth = 0;

  late AuthenticationProvider auth;
  late NavigationService navigation;

  final _loginFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvider>(context);
    navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(height: _deviceHeight * 0.04),
            _loginForm(),
            SizedBox(height: _deviceHeight * 0.05),
            _loginButton(),
            SizedBox(height: _deviceHeight * 0.02),
            _registerAccountLink()
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      height: _deviceHeight * 0.1,
      child: const Text(
        "Dosti",
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false),
            CustomTextFormField(
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscureText: true)
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
        name: "Login",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            auth.loginUsingEmailAndPassword(email: email, password: password);
          }
        });
  }

  Widget _registerAccountLink() {
    return GestureDetector(
        onTap: () {
          debugPrint("Clicked!");
        },
        child: const Text(
          "Don't you have an account?",
          style: TextStyle(color: Colors.blueAccent),
        ));
  }
}
