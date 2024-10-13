import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/Fill%20Profile/presentation/controller/fillprofile_states.dart';
import 'package:newsapp/features/news/presentation/view/home_screen.dart';


import '../../../../sharedwidget/Custom_textformfeild.dart';
import '../../../../sharedwidget/button.dart';
import '../../../signup/presentation/controller/signup_cubit.dart';
import '../controller/fillprofile_cubit.dart';

class fillprofile extends StatefulWidget {
  const fillprofile({super.key});

  @override
  State<fillprofile> createState() => _fillprofileState();
}

class _fillprofileState extends State<fillprofile> {



  @override
  Widget build(BuildContext context) {

    // var uid= BlocProvider.of<SignupCubit>(context).userid;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: BlocConsumer<FillprofileCubit,FillprofileStates>(
        listener: (context, state) {
             if (state is FillprofilFinishState ){
               Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(builder: (context) => newspage()),
                     (Route<dynamic> route) => false, // This removes all previous routes
               );
             } else if(state is FillprofileLoadingState){

             }
        },
          builder: (context, state) {

          return ModalProgressHUD(
              inAsyncCall: state is FillprofileLoadingState,
              progressIndicator: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),

              child: Padding(
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

                    BlocBuilder<FillprofileCubit, FillprofileStates>(builder: (context, state) {
                      return  Stack(
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
                            child: BlocProvider.of<FillprofileCubit>(context).myPhoto==null?
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
                      );
                    },),



                    SizedBox(height:MediaQuery.sizeOf(context).height*0.05 ,),

                    BlocBuilder<FillprofileCubit,FillprofileStates>(
                      builder: (context, state) {
                        return  CustomTextformfeild(
                          controller: BlocProvider.of<FillprofileCubit>(context).fullname,
                          formKey:  BlocProvider.of<FillprofileCubit>(context).key1,
                          validator:(p0) =>  BlocProvider.of<FillprofileCubit>(context).Validatorname(p0),
                          obscureText: false,
                          suffixIcon: null,
                          keyboardType: TextInputType.name,
                          textfeild: AppTexts.fullname,
                        );
                      },

                    ) ,

                    SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

                    BlocBuilder<FillprofileCubit,FillprofileStates>(
                      builder: (context, state) {
                        return    CustomTextformfeild(
                          controller: BlocProvider.of<FillprofileCubit>(context).Emailaddress,
                          formKey: BlocProvider.of<FillprofileCubit>(context).key2,
                          validator: (p0) => BlocProvider.of<FillprofileCubit>(context).ValidatorEmail(p0),
                          obscureText: false,
                          suffixIcon: null,
                          keyboardType: TextInputType.emailAddress,
                          textfeild: AppTexts.Email,
                        );
                      },
                    ),


                    SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

                    BlocBuilder<FillprofileCubit,FillprofileStates>(
                      builder: (context, state) {
                        return  CustomTextformfeild(
                          controller: BlocProvider.of<FillprofileCubit>(context).phonenumber,
                          formKey: BlocProvider.of<FillprofileCubit>(context).key3,
                          validator:(p0) =>  BlocProvider.of<FillprofileCubit>(context).ValidatorNumber(p0),
                          obscureText: false,
                          suffixIcon: null,
                          keyboardType: TextInputType.phone,
                          textfeild: AppTexts.Phone,
                        );
                      },
                    ),


                    SizedBox(height:MediaQuery.sizeOf(context).height*0.1 ,),


                    BlocBuilder<FillprofileCubit,FillprofileStates>(
                      builder: (context, state) {

                        return buttonshare(text: AppTexts.Next, onTap: () {


                          BlocProvider.of<FillprofileCubit>(context).Fillproile_Done( context: context, );

                          BlocProvider.of<FillprofileCubit>(context).saveProfileAfterGoogleSignIn();

                          // BlocProvider.of<FillprofileCubit>(context).savePerson();


                        },);
                      },

                    ),







                  ],
                ),
              )


          );

          },

      ),




    );
  }
}
