

import '../repositories/firebase_repository.dart';

class GetCurrentUidUseCase{
  FirebaseRepository repository;

  GetCurrentUidUseCase(this.repository);

  Future<String> call()async{
    return await repository.getCurrentUID();
  }
}