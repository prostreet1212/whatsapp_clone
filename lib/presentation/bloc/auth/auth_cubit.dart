import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/presentation/bloc/auth/auth_state.dart';

import '../../../domain/usecases/get_current_uid_usecase.dart';
import '../../../domain/usecases/is_sign_in_use_case.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.isSignInUseCase,
    required this.getCurrentUidUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());


  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn){
        final uid=await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      }else{
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future <void> loggedIn() async{
    try{
      final uid=await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    }catch(_){

    }
  }

  Future<void> LoggedOut()async{
   try{
     await signOutUseCase.call();
     emit(UnAuthenticated());
   }catch(_){

   }
  }


}
