import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Appimages.dart';
import 'package:newsapp/features/News/presentation/view/homebody.dart';
import 'package:newsapp/features/news/presentation/view/widgets/author.dart';
import 'package:newsapp/features/news/presentation/view/widgets/bookmark.dart';
import 'package:newsapp/features/news/presentation/view/widgets/topic_Screen.dart';
import 'package:newsapp/sharedwidget/appbar_home.dart';
import '../../../Fill Profile/Data/model/fillprofile_model.dart';
import '../../../Fill Profile/presentation/controller/fillprofile_cubit.dart';


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
    Author(),
    Bookmark(),
  ] ;

  @override
  Widget build(BuildContext context) {

   //  final box = Hive.box<FillprofileModel>('ProfileBox');
   // final data= box.get("Data");


    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context,
          snapshot) {

        return   Scaffold(

            appBar: PreferredSize(
                preferredSize: Size.fromHeight(220),
                child:AppbarHome()

            ),

            body:screens[CurrentIndex],

            bottomNavigationBar: BottomNavigationBar(
                currentIndex:CurrentIndex ,
                onTap: (bottomIndex){
                  setState(() {
                    CurrentIndex = bottomIndex;
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

                  BottomNavigationBarItem(
                    label: 'Author',
                    icon: Icon(CupertinoIcons.building_2_fill),),

                  BottomNavigationBarItem(
                    label: 'Bookmark',
                    icon: Icon(CupertinoIcons.bookmark),
                  ),
                ]
            ),





        );
      },
  
    );
  }
}
