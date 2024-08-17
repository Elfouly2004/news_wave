import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Appimages.dart';
import 'package:newsapp/features/login/login.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override


  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    Future.delayed(const Duration(
        seconds: 2
    ) , () {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (C) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        return loginscreen();
      } ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
       children: [

         Spacer(),


         Center(
           child: ZoomIn(
          child: Image(
            image: AssetImage(AppImages.NewsLogo),
          height:MediaQuery.sizeOf(context).height*0.2 ,
            width:MediaQuery.sizeOf(context).height*0.2 ,
          ),

           ),
         ),

         Spacer(),



       ],
      ),
    );
  }
}
