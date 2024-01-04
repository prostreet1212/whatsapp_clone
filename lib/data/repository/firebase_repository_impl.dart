import 'package:whatsapp_clone/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class FirebaseRepositotyImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;
  FirebaseRepositotyImpl({required this.remoteDataSource});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      await remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUID() async =>
      await remoteDataSource.getCurrentUID();

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async =>
      await remoteDataSource.signInWithPhoneNumber(smsPinCode);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async =>
      await remoteDataSource.verifyPhoneNumber(phoneNumber);

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) {
    throw UnimplementedError();
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) {
    // TODO: implement createOneToOneChatChannel
    throw UnimplementedError();
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    // TODO: implement getMyChat
    throw UnimplementedError();
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid) {
    // TODO: implement getOneToOneSingleUserChannelId
    throw UnimplementedError();
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }
}
