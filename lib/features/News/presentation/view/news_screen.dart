import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Appimages.dart';
import 'package:newsapp/features/news/presentation/view/widgets/author.dart';
import 'package:newsapp/features/news/presentation/view/widgets/bookmark.dart';
import 'package:newsapp/features/news/presentation/view/widgets/topic_Screen.dart';
import 'package:newsapp/features/news/presentation/view/widgets/homebody.dart';
import 'package:newsapp/features/setting/presentation/view/setting.dart';
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
    Homebody(),
    TopicScreen(),
    Author(),
    Bookmark(),
  ] ;

  @override
  Widget build(BuildContext context) {

    final box = Hive.box<FillprofileModel>('ProfileBox');
   final data= box.get("Data");


    return Scaffold(

    appBar: PreferredSize(
      preferredSize: Size.fromHeight(220),
      child:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs.first;

          return Padding(
            padding:  EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 10),
            child: AppBar(
              toolbarHeight: 80,

              leading: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(data['imageurl']),
                backgroundColor: AppColors.white,
              ),

              centerTitle: true,
              title: Column(

                children: [
                  SizedBox(height: 10,),
                  Image(image: AssetImage(AppImages.Newswavepic),height: 32,width:93 ,),
                  SizedBox(height: 10,),
                  Image(image: AssetImage(AppImages.Newswavetxt),height: 24,width: 144,)
                ],
              ),

                 actions: [
                   IconButton(
                       onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Setting(),));
                   }, icon: Icon(Icons.settings,size: 30,))
                 ],



              bottom:PreferredSize(preferredSize: Size.fromHeight(0),
                  child:TextFormField(

                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle:  TextStyle(color: AppColors.blue,fontSize: 20),
                        prefixIcon: Icon(CupertinoIcons.search,size:30,color: AppColors.blue,),
                        border: OutlineInputBorder(borderSide: BorderSide(color:  AppColors.blue)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blue)),
                        enabledBorder: OutlineInputBorder(borderSide:  BorderSide(color: AppColors.blue),)
                    ),
                  )
              ),

            ),
          );
        },
      ),







    ),


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

       body:screens[CurrentIndex]



    );
  }
}
