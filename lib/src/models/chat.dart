//Models
// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field

import 'chat_message.dart';
import 'chat_user.dart';

class Chat {
  final String uid, currentUserUid;
  final bool activity, group;
  final List<ChatUser> members;
  List<ChatMessage> messages;
  late final List<ChatUser> _recepients;

  Chat(
      {required this.uid,
      required this.currentUserUid,
      required this.activity,
      required this.group,
      required this.members,
      required this.messages}) {
    _recepients = members.where((_i) => _i.uid != currentUserUid).toList();
  }

  List<ChatUser> recepients() {
    return _recepients;
  }

  String title() {
    return !group
        ? _recepients.first.name
        : _recepients.map((_user) => _user.name).join(', ');
  }

  String imageURL() {
    return !group
        ? _recepients.first.imageURL
        : "https://cdn-icons-png.flaticon.com/512/10728/10728169.png";
  }
}
