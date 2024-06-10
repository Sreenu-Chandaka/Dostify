// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

String USER_COLLECTION = "Users";

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // CloudStorageService() {}

  Future<String?> saveUserImageToStorage(
      String? _uid, PlatformFile _file) async {
    try {
      Reference _ref =
          _storage.ref().child("users/images/$_uid/profile.${_file.extension}");
      UploadTask _task = _ref.putFile(File(_file.path!));
      return await _task.then((_result) => _result.ref.getDownloadURL());
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> saveChatImageToStorage(
      String? _userID, String? _chatID, PlatformFile _file) async {
    try {
      Reference _ref = _storage.ref().child(
          "images/chats/$_chatID/$_userID/${Timestamp.now().microsecondsSinceEpoch}.${_file.extension}");
      UploadTask _task = _ref.putFile(File(_file.path!));
      return await _task.then((_result) => _result.ref.getDownloadURL());
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
