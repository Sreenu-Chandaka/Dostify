import 'package:flutter/material.dart';

//Packages
import "package:firebase_core/firebase_core.dart";

class SplashScreen extends StatefulWidget{
  const SplashScreen({ required Key key, required this.onIntializationComplete});
  final VoidCallback onIntializationComplete;

  @override
  State<StatefulWidget> createState() {
   
    return _SplashScreenState();
  }

}
  class _SplashScreenState extends State<SplashScreen>{
 @override
    void initState(){
      super.initState();
      _setup().then((_) =>widget.onIntializationComplete );

    }
  @override
  Widget build(BuildContext context) {

   return MaterialApp(title: "Dostify",theme: ThemeData(scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1),
   ),
   home: Scaffold(body: Center(child: Container(height: 200,width: 200,decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/splash_image.png"))),),),),
   
);
  
  }

  } 

  Future<void> _setup()async{
    WidgetsFlutterBinding.ensureInitialized();
    await  Firebase.initializeApp();
    _regiterServices();
  }

  void _regiterServices(){

  }
  
