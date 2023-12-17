import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final bool isOnline;
  final String uid;
  final String status;
  final String profileUrl;

  UserEntity({
    this.name,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.uid,
    this.status,
    this.profileUrl,
  });

  @override
  List<Object?> get props => [
        this.name,
        this.email,
        this.phoneNumber,
        this.isOnline,
        this.uid,
        this.status,
        this.profileUrl
      ];
}
