import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/data/model/user_model.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/presentation/bloc/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/user/user_cubit.dart';
import 'package:whatsapp_clone/presentation/screens/home_screen.dart';
import 'package:whatsapp_clone/presentation/screens/splash_screen.dart';
import 'package:whatsapp_clone/presentation/screens/welcome_screen.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';
import 'package:whatsapp_clone/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (_) => di.sl<PhoneAuthCubit>()),
        BlocProvider(create: (_)=>di.sl<UserCubit>()..getAllUsers()),
        BlocProvider(create: (_)=>di.sl<GetDeviceNumberCubit>())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Clone',
        theme: ThemeData(
          //primaryColor: primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: false,
        ),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
               return BlocBuilder<UserCubit,UserState>(
                   builder: (context,userState){
                     if(userState is UserLoaded){
                       final currentUserInfo=userState.users
                           .firstWhere((user) => user.uid==authState.uid,
                           orElse: ()=>UserModel());
                       return HomeScreen(userInfo:currentUserInfo);
                     }
                     return Container();
                   });
              }
              if (authState is UnAuthenticated) {
                return WelcomeScreen();
              }
              return Container();
            });
          }
        },
      ),
    );
  }
}
