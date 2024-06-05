

//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';

//Services
import '../services/navigation_service.dart';


//Widgets
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';

//Providers
import '../providers/authentication_provider.dart';




class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
   return _RegisterPageState();
  }
  
}

class _RegisterPageState extends State<RegisterPage>{
  @override
  Widget build(BuildContext context) {
  return _buildUI();
  }
  Widget _buildUI(){
    return const Scaffold();
  }
}