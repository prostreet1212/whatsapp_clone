import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsapp_clone/data/model/user_model.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  String _verificationId = '';

  FirebaseRemoteDataSourceImpl({required this.auth, required this.fireStore});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection('users');
    final uid = await getCurrentUID();
    userCollection.doc(uid).get().then((userDoc) {
      Map<String,dynamic> newUser = UserModel(
              name: user.name,
              email: user.email,
              phoneNumber: user.phoneNumber,
              isOnline: user.isOnline,
              uid: uid,
              status: user.status,
              profileUrl: user.profileUrl)
          .toDocument();
      if(!userDoc.exists){
        //create new user
        userCollection.doc(uid).set(newUser);
      }else{
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<String> getCurrentUID() async {
    return auth.currentUser!.uid;
  }

  @override
  Future<bool> isSignIn() async {
    return auth.currentUser!.uid != null;
  }

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode,);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      print('phone verified: Token ${authCredential.token}');
    };
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      print(
          'phone failed: ${firebaseAuthException.message}, ${firebaseAuthException.code}');
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print('time out: ${verificationId}');
    };
    final PhoneCodeSent phoneCodeSent =
        (String verificationId, int? forceResendingToken) {};
    await auth.setSettings(/*appVerificationDisabledForTesting: true*/);
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        timeout: const Duration(seconds: 10),
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }
}
