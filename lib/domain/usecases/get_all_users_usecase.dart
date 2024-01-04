import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';

class GetAllUsersUseCase {
  FirebaseRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
