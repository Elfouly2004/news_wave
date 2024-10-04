import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/News/presentation/controller/search_cubit/search_cubit.dart';

import '../core/utils/Appcolors.dart';
import '../core/utils/Appimages.dart';
import '../features/setting/presentation/view/setting.dart';
import 'Search.dart';

class AppbarHome extends StatefulWidget {
  const AppbarHome({super.key});

  @override
  State<AppbarHome> createState() => _AppbarHomeState();
}

class _AppbarHomeState extends State<AppbarHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        toolbarHeight: 120,
        leading: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: AppColors.blue,
              ));
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
            SizedBox(height: 10),
            Image(
              image: AssetImage(AppImages.Newswavepic),
              height: 32,
              width: 93,
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage(AppImages.Newswavetxt),
              height: 24,
              width: 144,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
            icon: Icon(Icons.settings, size: 30),
          )
        ],
        // bottom: PreferredSize(
        //     preferredSize: Size.fromHeight(0),
        //     child:
        // )
      ),
    );
  }
}
