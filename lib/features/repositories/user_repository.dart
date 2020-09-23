import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style/components/models/user.dart';
import 'package:style/features/repositories/user_client.dart';

class UserRepository {
  UserRepository._();
  static final UserRepository userRepository = UserRepository._();

  Future<User> getUserInfo(String documentId)async{
    DocumentSnapshot dc=await UserClient.userClient.isAdmin(documentId);
    User user=User.fromDocumentSnapshot(dc);
    return user;

  }
}
