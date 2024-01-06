import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
     String name='',
      String email='',
     String phoneNumber='',
     bool isOnline=false,
     String uid='',
     String status='',
     String profileUrl='',
  }) : super(
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            isOnline: isOnline,
            uid: uid,
            status: status,
            profileUrl: profileUrl);


  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      uid: data['uid'],
      isOnline: data['isOnline'],
      profileUrl: data['profileUrl'],
      status: data['status'],
    );
  }

 /* factory UserModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      phoneNumber: snapshot['phoneNumber'],
      uid: snapshot['uid'],
      isOnline: snapshot['isOnline'],
      profileUrl: snapshot['profileUrl'],
      status: snapshot['status'],
    );
  }*/

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "isOnline": isOnline,
      "profileUrl": profileUrl,
      "status": status,
    };
  }
}
