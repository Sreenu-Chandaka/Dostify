// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';

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
  List<ChatMessage>? messages;
  late StreamSubscription _messagesStream;
  String? _message;

  ChatPageProvider(this._auth, this.chatId, this._messageListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _media = GetIt.instance.get<MediaService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
     listenToMessages();
  }

  @override
  void dispose() {
     _messagesStream.cancel();
    super.dispose();
   
  }

  void listenToMessages(){
    try{
      _messagesStream=_db.streamMessagesForChat(chatId).listen((_snapshot) { 
        List<ChatMessage> _messages=_snapshot.docs.map((_m) {
          Map<String, dynamic> _messageData=_m.data() as Map<String,dynamic>;
          return ChatMessage.fromJSON(_messageData);

        }).toList();
        messages=_messages;
        notifyListeners();
      });
    }catch(e){
      print("Error getting Messages");
      print(e);
    }

  }

  void goBack() {
    _navigation.goBack();
  }
}
