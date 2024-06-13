// ignore_for_file: empty_constructor_bodies, constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String USER_COLLECTION = "Users";
const String CHATS_COLLECTION = "Chats";
const String MESSAGES_COLLECTION = "messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // DatabaseService(){}

  Future<void> createUser(
      {String? uid, String? name, String? imageURL, String? email}) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).set({
        "name": name,
        "email": email,
        "last_active": DateTime.now().toUtc(),
        "image": imageURL
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<DocumentSnapshot> getUser(String uid) {
    return _db.collection(USER_COLLECTION).doc(uid).get();
  }

  Stream<QuerySnapshot> getChatsForUser(String uid) {
    print(_db
        .collection(CHATS_COLLECTION)
        .where('members', arrayContains: uid)
        .snapshots());
        print("//////////////////////printing in database service////////////////////////////////////////////////");
    return _db
        .collection(CHATS_COLLECTION)
        .where('members', arrayContains: uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForUser(String _chatID) {
    return _db
        .collection(CHATS_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION).orderBy("sent_time",descending: true)
        .limit(1)
        .get();
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).update({
        "last_active": DateTime.now().toUtc(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
