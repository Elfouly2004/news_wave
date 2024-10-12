import 'package:flutter/material.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Appimages.dart';
import 'package:newsapp/core/utils/Apptexts.dart';

class anotherlogin extends StatelessWidget {
  const anotherlogin ({super.key, this.onTap1, this.onTap2});
final void Function()? onTap1;
final void Function()? onTap2;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        GestureDetector(
          onTap: onTap1,
          child: Container(
            height: 47,
            width: 160,
            decoration: BoxDecoration(
              color:AppColors.continer,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage(AppImages.facebook),height:24 ,width:24 ,),

                Text(AppTexts.facebook,style: TextStyle(color: AppColors.anotherlogin,
                fontWeight: FontWeight.w600,fontSize: 16),)
              ],
            ),
          ),
        ) ,

        GestureDetector(
          onTap: onTap2,
          child: Container(
            height: 47,
            width: 174,
            decoration: BoxDecoration(
              color:AppColors.continer,
         borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage(AppImages.google),height:24 ,width:24 ,),

                Text(AppTexts.Google,style: TextStyle(color: AppColors.anotherlogin,
                fontWeight: FontWeight.w600,fontSize: 16),)
              ],
            ),
          ),
        )

      ],
    );
  }
}
