

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/presentation/bloc/auth/auth_state.dart';

import '../../../domain/usecases/get_current_uid_usecase.dart';
import '../../../domain/usecases/is_sign_in_use_case.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

class AuthCubit extends Cubit<AuthState>{

  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit(this.isSignInUseCase, this.getCurrentUidUseCase, this.signOutUseCase,):super(AuthInitial());


  Future<void> appStarted()async{

  }
}