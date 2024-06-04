import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:get_it/get_it.dart";

//Services
import "../services/database_service.dart";
import "../services/navigation_service.dart";

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _databaseService.getUser(user.uid);
        _databaseService.updateUserLastSeenTime(user.uid);
        debugPrint("logged in");
      } else {
        debugPrint("Not Authenticated");
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      {String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      print(_auth.currentUser);
    } on FirebaseException {
      debugPrint("Error logging user into Firbase");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
