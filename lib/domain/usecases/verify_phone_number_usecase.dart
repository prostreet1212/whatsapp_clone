

import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class VerifyPhoneNumberUseCase{
  final FirebaseRepository repository;

  VerifyPhoneNumberUseCase({required this.repository});
  
  Future<void> call({required String phoneNumber})async{
    return await repository.verifyPhoneNumber(phoneNumber);
  }
}