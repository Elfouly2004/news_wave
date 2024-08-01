import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/Fill%20Profile/controller/controller.dart';
import 'package:provider/provider.dart';

import '../../sharedwidget/Custom_textformfeild.dart';

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


            SizedBox(height:MediaQuery.sizeOf(context).height*0.1 ,),


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

            SizedBox(height:MediaQuery.sizeOf(context).height*0.05 ,),




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

               Provider.of<fillprofilecontroller>(context).myPhoto==null?
                      Icon(Icons.photo)
                      : ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.file(
                        File( Provider.of<fillprofilecontroller>(context) .myPhoto!.path),
                        fit: BoxFit.cover,)
                  ),
                ),

                GestureDetector(
                  onTap: () {

                    Provider.of<fillprofilecontroller>(context,listen: false).choosephoto();

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



            CustomTextformfeild(
              key:  Provider.of<fillprofilecontroller>(context).formkey1,
              validator: null,
              obscureText: false,
              suffixIcon: null,
              keyboardType: TextInputType.name,
              textfeild: AppTexts.fullname,
            ) ,

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

            CustomTextformfeild(
              key:  Provider.of<fillprofilecontroller>(context).formkey2,
              validator: null,
              obscureText: false,
              suffixIcon: null,
              keyboardType: TextInputType.emailAddress,
              textfeild: AppTexts.Email,
            ) ,

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

            CustomTextformfeild(
              key:  Provider.of<fillprofilecontroller>(context).formkey3,
              validator: null,
              obscureText: false,
              suffixIcon: null,
              keyboardType: TextInputType.phone,
              textfeild: AppTexts.Phone,
            ) ,








        ],
        ),
      ),
    );
  }
}
