import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/presentation/bloc/phone_auth/phone_auth_state.dart';

import '../../../domain/usecases/get_create_current_user_usecase.dart';
import '../../../domain/usecases/sign_in_with_phone_number_usecase.dart';
import '../../../domain/usecases/verify_phone_number_usecase.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  PhoneAuthCubit({required this.signInWithPhoneNumberUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.getCreateCurrentUserUseCase})
      : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    emit(PhoneAuthLoading());
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber: phoneNumber);
      emit(PhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSmsCode({required String smsCode}) async {
    try {
      await signInWithPhoneNumberUseCase.call(smsPinCode: smsCode);
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitProfileInfo(
      {required String name,
        required String profileUrl,
        required String phoneNumber,
      }) async {
    try {
      await getCreateCurrentUserUseCase.call(user: UserEntity(
          name: name,
          email: '',
          phoneNumber: phoneNumber,
          isOnline: true,
          uid: '',
          status: '',
          profileUrl: profileUrl));
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

}
