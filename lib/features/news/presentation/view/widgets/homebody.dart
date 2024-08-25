import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../Fill Profile/Data/model/fillprofile_model.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<FillprofileModel>('ProfileBox');
    final person= box.get("Data");
    return Scaffold(
     body: Column(
       children: [
         
         Center(child: Text("${person!.Fullname}",style:  TextStyle(fontSize: 20),))
         
       ],
     ), 
      
    );
  }
}
