import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsapp_clone/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:whatsapp_clone/data/local_datasource/local_data_source.dart';
import 'package:whatsapp_clone/data/repository/firebase_repository_impl.dart';
import 'package:whatsapp_clone/data/repository/get_device_number_repository_impl.dart';
import 'package:whatsapp_clone/domain/repositories/firebase_repository.dart';
import 'package:whatsapp_clone/domain/repositories/get_device_number_repository.dart';
import 'package:whatsapp_clone/domain/usecases/get_create_current_user_usecase.dart';
import 'package:whatsapp_clone/domain/usecases/get_current_uid_usecase.dart';
import 'package:whatsapp_clone/domain/usecases/get_device_numbers_usecase.dart';
import 'package:whatsapp_clone/domain/usecases/is_sign_in_use_case.dart';
import 'package:whatsapp_clone/presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/communication/communication_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/user/user_cubit.dart';

import 'domain/usecases/add_to_my_chat_usecase.dart';
import 'domain/usecases/create_one_to_one_chat_channel_usecase.dart';
import 'domain/usecases/get_all_users_usecase.dart';
import 'domain/usecases/get_my_chat_usecase.dart';
import 'domain/usecases/get_one_to_one_single_user_chat_channel_usecase.dart';
import 'domain/usecases/get_text_messages_usecase.dart';
import 'domain/usecases/send_text_message_usecase.dart';
import 'domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/verify_phone_number_usecase.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //future bloc
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(
          isSignInUseCase: sl.call(),
          getCurrentUidUseCase: sl.call(),
          signOutUseCase: sl.call()));

  sl.registerFactory<PhoneAuthCubit>(() =>
      PhoneAuthCubit(
        signInWithPhoneNumberUseCase: sl.call(),
        verifyPhoneNumberUseCase: sl.call(),
        getCreateCurrentUserUseCase: sl.call(),
      ));
  sl.registerFactory<GetDeviceNumberCubit>(() =>
      GetDeviceNumberCubit(
          getDeviceNumberUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() =>
      UserCubit(
          getAllUserUseCase: sl.call(),
          createOneToOneChatChannelUseCase: sl.call()));
  sl.registerFactory<CommunicationCubit>(() =>
      CommunicationCubit(sendTextMessagesUseCase: sl.call(),
          getOneToOneSingleUserChatChannelUseCase: sl.call(),
          getTextMessagesUseCase: sl.call(),
          addToMyChatUseCase: sl.call()));
  sl.registerFactory<MyChatCubit>(() => MyChatCubit(
      getMyChatUseCase: sl.call()));


  //usecase
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
          () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
          () => GetCurrentUidUseCase(sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
          () => SignInWithPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
          () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
          () => VerifyPhoneNumberUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetAllUsersUseCase>(
          () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMyChatUseCase>(
          () => GetMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetTextMessagesUseCase>(
          () => GetTextMessagesUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
          () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<AddToMyChatUseCase>(
          () => AddToMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<CreateOneToOneChatChannelUseCase>(
          () => CreateOneToOneChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetOneToOneSingleUserChatChannelUseCase>(
          () => GetOneToOneSingleUserChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetDeviceNumberUseCase>(
          () => GetDeviceNumberUseCase(deviceNumberRepository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
          () => FirebaseRepositotyImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<GetDeviceNumberRepository>(
          () => GetDeviceNumberRepositoryImpl(localDataSource: sl.call()));

  //remote data
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), fireStore: sl.call()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
