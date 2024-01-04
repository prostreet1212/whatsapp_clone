import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class IsSignInUseCase{
  FirebaseRepository repository;

  IsSignInUseCase(this.repository);

  Future<bool> call() async{
    return await repository.isSignIn();
  }
}