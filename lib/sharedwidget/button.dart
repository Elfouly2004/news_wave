import 'package:flutter/material.dart';
import 'package:newsapp/core/utils/Appcolors.dart';

class buttonshare extends StatelessWidget {
   buttonshare({required this.text,required this.onTap});

   final String? text ;
   final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:onTap,
        child: Container(
          height: 50,
          width: 379,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text("${text}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.white
            ),),
          ),
        ));
  }
}
