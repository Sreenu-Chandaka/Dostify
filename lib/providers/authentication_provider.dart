// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import "package:cloud_firestore/cloud_firestore.dart";
import "package:dostify/models/chat_user.dart";
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
  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    
    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then((_snapshot) {
          Map<String, dynamic> _userData =
              _snapshot.data()! as Map<String, dynamic>;
          user = ChatUser.fromJSON({
            'uid': _user.uid,
            'name': _userData['name'],
            'email': _userData["email"],
            "image": _userData["image"],
            "last_active": _userData["last_active"]
          });
        });
        debugPrint("logged in......./////////////////////////");
        _navigationService.removeAndNavigateToRoute('/home');
        debugPrint("logged in");
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
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

  Future<String?> registerUserUsingEmailAndPassword(
      {String? email, String? password}) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return _credentials.user!.uid;
    } on FirebaseException {
      debugPrint("Error registering user");
    } catch (e) {
      print("getting error is ......//////////////////////////////////////////////////////////////////");
      print(e);
    }
    return null;
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
