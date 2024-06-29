// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:dostify/src/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/services/navigation_service.dart';

//pages
import 'src/pages/login_page.dart';
import 'src/pages/splash_screen.dart';
import 'src/pages/home_page.dart';
import 'src/pages/register_page.dart';

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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(create: (context) {
          return AuthenticationProvider();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dostify',
        theme: ThemeData(
            backgroundColor: const Color.fromRGBO(36, 35, 49, 1),
            scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
            )),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          "/login": (BuildContext _context) => const LoginPage(),
          '/home': (BuildContext _context) => const HomePage(),
          '/register': (BuildContext _context) => const RegisterPage()
        },
      ),
    );
  }
}
