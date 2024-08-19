import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/Fill%20Profile/controller/fillprofile_cubit.dart';
import 'package:newsapp/features/login/controller/login_cubit.dart';
import 'package:newsapp/features/signup/controller/signup_cubit.dart';
import 'package:newsapp/firebase_options.dart';
import 'features/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiBlocProvider(
      providers: [
        BlocProvider<SignupCubit>(
          create: (context) => SignupCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),

        BlocProvider<FillprofileCubit>(
          create: (context) => FillprofileCubit(),
        ),

      ],
      child:  MyApp()
      ),
  );



}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
debugShowCheckedModeBanner: false,
      home:splashscreen (),
    );
  }
}
