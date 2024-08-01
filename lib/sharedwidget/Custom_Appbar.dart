import 'package:flutter/material.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Appimages.dart';


class Custom_Appbar extends StatelessWidget {
   Custom_Appbar ({super.key,required this.widget,required this.height});
   final widget;
   final double? height;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue,
        toolbarHeight:MediaQuery.sizeOf(context).height*0.3,
      title: Center(
        child: Image(image: AssetImage(AppImages.NewsLogo),
          height:MediaQuery.sizeOf(context).height*0.2 ,
          width:MediaQuery.sizeOf(context).height*0.2 ,),
      ),

    bottom: PreferredSize(
    preferredSize: Size.fromHeight(0),
    child: Container(
      height: height,
      decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(80.0),),),
      child: widget,



    ),
    ),


    );
  }
}
