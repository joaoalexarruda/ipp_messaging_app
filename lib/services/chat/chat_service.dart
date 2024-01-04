import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get instance of the service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();

        // return the user
        return user;
      }).toList();
    });
  }

  // send message

  // get messages
}
