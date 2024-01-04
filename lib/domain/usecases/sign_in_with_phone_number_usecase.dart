

import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class SignInWithPhoneNumberUseCase{
  final FirebaseRepository repository;

  SignInWithPhoneNumberUseCase({required this.repository});

  Future<void> call({required String smsPinCode})async{
    return await repository.signInWithPhoneNumber(smsPinCode);

  }
}