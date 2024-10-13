import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Appimages.dart';
import 'package:newsapp/features/Bookmark/presentation/controller/book_mark_cubit.dart';
import 'package:newsapp/features/News/presentation/view/homebody.dart';
import 'package:newsapp/features/news/presentation/view/widgets/author.dart';
import 'package:newsapp/sharedwidget/appbar_home.dart';
import '../../../Bookmark/presentation/view/bookmark.dart';
import '../../../Fill Profile/Data/model/fillprofile_model.dart';
import '../../../Fill Profile/presentation/controller/fillprofile_cubit.dart';
import '../../../Topic/presentation/view/topic_Screen.dart';


class newspage extends StatefulWidget {
  const newspage({super.key});

  @override
  State<newspage> createState() => _newspageState();
}

class _newspageState extends State<newspage> {

  int CurrentIndex =  0;




  List<Widget> screens  = [
    Homebody_News(),
    TopicScreen(),
    // Author(),
    BookMarksScreen(),
  ] ;


  @override
  Widget build(BuildContext context) {

   //  final box = Hive.box<FillprofileModel>('ProfileBox');
   // final data= box.get("Data");


    return Scaffold(
      backgroundColor: AppColors.white,

        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child:AppbarHome()

        ),

        body:screens[CurrentIndex],

        bottomNavigationBar: BottomNavigationBar(
            currentIndex:CurrentIndex ,
            onTap: (bottomIndex){
              CurrentIndex = bottomIndex;
              setState(() {

              });
            },
            selectedItemColor: AppColors.blue,
            unselectedItemColor: Colors.black87.withOpacity(0.7),
            iconSize: 30,

            items: [

              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                label: "Home",),


              BottomNavigationBarItem(
                label: 'Topic',
                icon: Icon(CupertinoIcons.list_bullet_indent),),

              // BottomNavigationBarItem(
              //   label: 'Author',
              //   icon: Icon(CupertinoIcons.building_2_fill),),

              BottomNavigationBarItem(
                label: 'Bookmark',
                icon: Icon(CupertinoIcons.bookmark),
              ),
            ]
        ),





    );
  }
}
