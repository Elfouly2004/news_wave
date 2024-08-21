import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Apptexts.dart';


import '../../../../sharedwidget/Custom_textformfeild.dart';
import '../../../../sharedwidget/button.dart';
import '../controller/fillprofile_cubit.dart';

class fillprofile extends StatefulWidget {
  const fillprofile({super.key});

  @override
  State<fillprofile> createState() => _fillprofileState();
}

class _fillprofileState extends State<fillprofile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [


            SizedBox(height:MediaQuery.sizeOf(context).height*0.06 ,),


            Center(
                child:Text(
                  AppTexts.fillprofile,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,

                ),
                )
            ),


            SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),



            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [

                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.blue,width: 2),

                  ),
                  child:

                  BlocProvider.of<FillprofileCubit>(context).myPhoto==null?
                      Icon(Icons.photo)
                      : ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.file(
                        File( BlocProvider.of<FillprofileCubit>(context) .myPhoto!.path),
                        fit: BoxFit.cover,)
                  ),
                ),

                GestureDetector(
                  onTap: () {

                    BlocProvider.of<FillprofileCubit>(context).choosephoto();

                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                       color: AppColors.camera
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.05 ,),

            CustomTextformfeild(
              controller: BlocProvider.of<FillprofileCubit>(context).fullname,
              formKey:  BlocProvider.of<FillprofileCubit>(context).key1,
              validator: null,
              obscureText: false,
              suffixIcon: null,
              keyboardType: TextInputType.name,
              textfeild: AppTexts.fullname,
            ) ,

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

            CustomTextformfeild(
              controller: BlocProvider.of<FillprofileCubit>(context).Emailaddress,
              formKey: BlocProvider.of<FillprofileCubit>(context).key2,
              validator: null,
              obscureText: false,
              suffixIcon: null,
              keyboardType: TextInputType.emailAddress,
              textfeild: AppTexts.Email,
            ) ,

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

            CustomTextformfeild(
              controller: BlocProvider.of<FillprofileCubit>(context).phonenumber,
              formKey: BlocProvider.of<FillprofileCubit>(context).key3,
              validator: null,
              obscureText: false,
              suffixIcon: null,
              keyboardType: TextInputType.phone,
              textfeild: AppTexts.Phone,
            ) ,

            SizedBox(height:MediaQuery.sizeOf(context).height*0.1 ,),


            buttonshare(text: AppTexts.Next, onTap: () {

            },),







          ],
        ),
      ),
    );
  }
}
