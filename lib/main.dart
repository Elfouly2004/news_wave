

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsapp/features/Bookmark/presentation/controller/book_mark_cubit.dart';
import 'package:newsapp/features/Fill%20Profile/presentation/view/fillprofile.dart';
import 'package:newsapp/features/News/Data/Repo/home_repo_implemetation.dart';
import 'package:newsapp/features/Topic/presentation/controller/categories_cubit.dart';
import 'package:newsapp/features/login/presentation/controller/login_cubit.dart';
import 'package:newsapp/features/login/presentation/view/login.dart';
import 'package:newsapp/features/news/presentation/view/news_screen.dart';
import 'package:newsapp/features/signup/presentation/controller/signup_cubit.dart';
import 'package:newsapp/features/splashscreen/splashscreen.dart';
import 'package:newsapp/firebase_options.dart';
import 'features/Editprofile/presentation/controller/editprofile_cubit.dart';
import 'features/Fill Profile/Data/model/fillprofile_model.dart';
import 'features/Fill Profile/presentation/controller/fillprofile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/News/presentation/controller/get_top_headline/get_top_headline_cubit.dart';


void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter((FillprofileModelAdapter()));
  await Hive.openBox<FillprofileModel>("ProfileBox");


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

        BlocProvider<EditprofileCubit>(
          create: (context) => EditprofileCubit(),
        ),

        BlocProvider<TopHeadlineCubit>(
          create: (context) => TopHeadlineCubit(homeRepo: HomeRepoImplementationFromApi()),
        ),

        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(),
        ),

        BlocProvider<BookMarkCubit>(
          create: (context) => BookMarkCubit(),
        ),



      ],
      child:  MyApp()
      ),
  );



}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<FillprofileModel>('ProfileBox');
    // final person= box.get("Data");

    BlocProvider.of<FillprofileCubit>(context).getProfile();
    return MaterialApp(
      title: 'News App',
     debugShowCheckedModeBanner: false,
      home: newspage(),
    );
  }
}