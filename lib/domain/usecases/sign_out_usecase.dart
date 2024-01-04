import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class SignOutUseCase{
  FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call()async{
    return await repository.signOut();
  }
}