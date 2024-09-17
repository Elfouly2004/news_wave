import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/utils/Appcolors.dart';
import '../core/utils/Appimages.dart';
import '../features/setting/presentation/view/setting.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome ({super.key,});


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10, bottom: 30),
      child: AppBar(
        toolbarHeight: 100,

        leading: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!.docs.first;



            return CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(data['imageurl']),
              backgroundColor: AppColors.white,
            );
          },
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
  }
}
