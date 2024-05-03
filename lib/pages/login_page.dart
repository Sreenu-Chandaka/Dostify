
import 'package:flutter/material.dart';

//Widgets
import "../widgets/custom_input_field.dart";
import "../widgets/rounded_button.dart";


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
  
    return _LoginPageState() ;
  }
}

  class _LoginPageState extends State<LoginPage> {
   double _deviceHeight=0;
   double _deviceWidth=0;

  final _loginFormKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  _deviceHeight=MediaQuery.of(context).size.height;
 _deviceWidth=MediaQuery.of(context).size.width;
   return _buildUI();
  }

  Widget _buildUI(){
   
    return Scaffold(body:
     Container(padding: EdgeInsets.symmetric(horizontal:_deviceWidth * 0.03 ,vertical:_deviceHeight*0.02 ),height: _deviceHeight*0.98,width: _deviceWidth*0.97,
     child: Column(mainAxisSize: MainAxisSize.max,
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children:
      [
     _pageTitle(),
     SizedBox(height: _deviceHeight*0.04),
     _loginForm(),
      SizedBox(height: _deviceHeight*0.05),
     _loginButton(),
     _registerAccountLink()
     ],),),);
  }
 Widget _pageTitle(){
  return SizedBox(height: _deviceHeight*0.1,child: const Text("Dostify",style: 
  TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w600),),);
}

Widget _loginForm(){
  return SizedBox(height: _deviceHeight*0.18,child: Form(key: _loginFormKey,child:  Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CustomTextFormField(onSaved: (_value){},  regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", hintText: "Email", obscureText: false),
                 
                    CustomTextFormField(onSaved: (_value){},  regEx:
                    r".{8,}", hintText: "Password", obscureText: true)],
  ),),);
}

Widget _loginButton(){
  return RoundedButton(name: "Login", height: _deviceHeight*0.065, width:_deviceWidth* 0.65, onPressed: (){

  });
}

Widget _registerAccountLink(){
  return 
  
   GestureDetector(
    onTap: (){
      print("Clicked!");
    },
    child: Container(child: const Text("Don't you have an account?",style: TextStyle(color: Colors.blueAccent),),));
}
  }
