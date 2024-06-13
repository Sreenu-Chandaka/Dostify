import 'dart:async';
//Packages
import 'package:dostify/helper/get_helper.dart';
import 'package:dostify/models/chat_user.dart';
import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Services
import '../services/database_service.dart';

//Providers
import '../providers/authentication_provider.dart';

//Models
import "../models/chat.dart";
import "../models/chat_message.dart";

class ChatsPageProvider extends ChangeNotifier {
  late DatabaseService _db;
  List<Chat>? chats;
  late StreamSubscription _chatsStream;

  ChatsPageProvider() {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    print(GetHelper.getCurrentUserId());
    print(
        "current user id in chat page provider ...////////////////////////////////////// ");
    try {
      _chatsStream = _db.getChatsForUser(GetHelper.getCurrentUserId()!).listen(
        (snapshot) async {
          print(snapshot.docs.map((d) {
            d.data();
          }));
          print("snapshots data..////////////////////////");
          chats = await Future.wait(
            snapshot.docs.map(
              (d) async {
                Map<String, dynamic> chatData =
                    d.data() as Map<String, dynamic>;

                //Get Users in Chat
                List<ChatUser> members = [];
                for (var uid in chatData['members']) {
                  DocumentSnapshot userSnapshot = await _db.getUser(uid);
                  Map<String, dynamic> userData =
                      userSnapshot.data() as Map<String, dynamic>;
                  ChatUser chatUser = ChatUser.fromJSON(userData);
                  members.add(chatUser);
                }

                //Get Last message for User
                List<ChatMessage> messages = [];
                QuerySnapshot chatMessage =
                    await _db.getLastMessageForUser(d.id);
                if (chatMessage.docs.isNotEmpty) {
                  Map<String, dynamic> messageData =
                      chatMessage.docs.first.data()! as Map<String, dynamic>;
                  ChatMessage message = ChatMessage.fromJSON(messageData);
                  messages.add(message);
                }

                //Return Chat Instance
                return Chat(
                    uid: d.id,
                    currentUserUid: GetHelper.getCurrentUserId()!,
                    activity: chatData['is_activity'],
                    group: chatData['is_group'],
                    members: members,
                    messages: messages);
              },
            ).toList(),
          );
          notifyListeners();
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(
          "getting chats error....//////////////////////////////////////////////////////////////////////////");
    }
  }
}
