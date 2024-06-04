// ignore_for_file: empty_constructor_bodies

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String USER_COLLECTION = "Users";
const String CHATS_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "Messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // DatabaseService(){}

  Future<DocumentSnapshot> getUser(String uid) {
    return _db.collection(USER_COLLECTION).doc(uid).get();
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      _db.collection(USER_COLLECTION).doc(uid).update({
        "last_active": DateTime.now(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
