import 'package:dostify/pages/login_page.dart';
import 'package:dostify/pages/splash_screen.dart';
import 'package:dostify/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import "package:firebase_analytics/firebase_analytics.dart";
import 'package:provider/provider.dart';
import 'services/navigation_service.dart';

void main() {
  runApp(
    SplashScreen(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          const MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationProvider>(create:(context){
        return AuthenticationProvider();
      })
    ],
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dostify',theme:ThemeData(backgroundColor: const Color.fromRGBO(36, 35, 49, 1),scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1),bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),)
     ),
     navigatorKey:NavigationService.navigatorKey,
     initialRoute: '/login',
       routes: {
      "/login":(BuildContext context)=> const LoginPage()
       },
     ),
   );
  }
  
}

