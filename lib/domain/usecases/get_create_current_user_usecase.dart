

import 'package:whatsapp_clone/domain/entities/user_entity.dart';

import '../repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase{
  FireBaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call({required UserEntity user})async{
    return await repository.getCreateCurrentUser(user);
  }
}