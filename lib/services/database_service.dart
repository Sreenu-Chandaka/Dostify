import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION="Users";
const String CHATS_COLLECTION="Chats";
const String MESSAGES_COLLECTION="Messages";

class DatabaseService{

  final FirebaseFirestore _db=FirebaseFirestore.instance;
  DatabaseService(){}

  Future<DocumentSnapshot>_getUser(String uid){
    return _db.collection(USER_COLLECTION).doc(uid).get();

  }

  


}