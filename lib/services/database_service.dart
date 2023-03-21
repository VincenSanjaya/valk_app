import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLCETION = "Users";
const String CHAT_COLLECTION = "Chats";
const String MESSAGE_COLLECTION = "Messages";

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService() {}


  Future<DocumentSnapshot> getUser(String uid) {
    return _db.collection(USER_COLLCETION).doc(uid).get();
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      await _db.collection(USER_COLLCETION).doc(uid).update({"lastSeen": DateTime.now().toUtc()});
    } catch (e) {
      print(e);
    }
  }
}