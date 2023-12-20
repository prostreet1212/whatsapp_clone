import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsapp_clone/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:whatsapp_clone/data/repository/firebase_repository_impl.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';
import 'package:whatsapp_clone/domain/usecases/get_create_current_user_usecase.dart';
import 'package:whatsapp_clone/domain/usecases/get_current_uid_usecase.dart';
import 'package:whatsapp_clone/domain/usecases/is_sign_in_use_case.dart';

import 'domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/verify_phone_number_usecase.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //future bloc

  //usecase
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
          () => IsSignInUseCase(sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
          () => SignInWithPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
          () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
          () => VerifyPhoneNumberUseCase(repository: sl.call()));
  //repository
  sl.registerLazySingleton(
      () => FirebaseRepositotyImpl(remoteDataSource: sl.call()));

  //remote data
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), fireStore: sl.call()));

  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
