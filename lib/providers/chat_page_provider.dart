// ignore_for_file: unused_field

import 'package:dostify/providers/authentication_provider.dart';
import 'package:dostify/services/cloud_storage_service.dart';
import 'package:dostify/services/database_service.dart';
import 'package:dostify/services/media_service.dart';
import 'package:dostify/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/chat_message.dart';

class ChatPageProvider extends ChangeNotifier {
  late NavigationService _navigation;
  late CloudStorageService _storage;
  late MediaService _media;
  final AuthenticationProvider _auth;

  late DatabaseService _db;

  final ScrollController _messageListViewController;
  String chatId;
  List<ChatMessage>? _messages;
  String? _message;

  ChatPageProvider(this._auth, this.chatId, this._messageListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _media = GetIt.instance.get<MediaService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goBack() {
    _navigation.goBack();
  }
}
