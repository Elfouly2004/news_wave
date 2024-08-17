import 'package:flutter/material.dart';
import 'package:newsapp/features/signup/controller/signupcontroller.dart';
import 'package:newsapp/firebase_options.dart';
import 'package:provider/provider.dart';
import 'features/Fill Profile/controller/controller.dart';
import 'features/login/controller/login_controller.dart';
import 'features/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) =>logincontroller()),
        ChangeNotifierProvider(create:(context) =>signupcontroller()),
        ChangeNotifierProvider(create:(context) =>fillprofilecontroller()),

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
