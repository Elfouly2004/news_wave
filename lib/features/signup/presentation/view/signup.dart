import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/login/presentation/view/login.dart';
import 'package:newsapp/features/signup/presentation/controller/signup_cubit.dart';
import 'package:newsapp/features/signup/presentation/controller/signup_states.dart';
import 'package:newsapp/sharedwidget/Custom_Appbar.dart';
import '../../../../core/utils/Appcolors.dart';
import '../../../../core/utils/Appimages.dart';
import '../../../../core/utils/Apptexts.dart';
import '../../../../sharedwidget/Custom_textformfeild.dart';
import '../../../../sharedwidget/anotherlogin.dart';
import '../../../../sharedwidget/button.dart';
import '../../../../sharedwidget/checkRow.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../../Fill Profile/presentation/view/fillprofile.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<SignupCubit>(context).Email.dispose();
    BlocProvider.of<SignupCubit>(context).Password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {
          if(state is SignupLoadingState){

          }else if(state is SignupFinishState){

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => fillprofile(),));

          }else if(state is SignupGoogleState){

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => fillprofile(),));

          }

        },


        builder: (context, state) {

          return ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            inAsyncCall: state is SignupLoadingState,
            child: Custom_Appbar(
              height: MediaQuery.sizeOf(context).height * 0.8,
              widget: Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

                    Center(
                      child: Image(
                        image: AssetImage(AppImages.signup),
                        height: MediaQuery.sizeOf(context).height * 0.04,
                        width: MediaQuery.sizeOf(context).height * 0.1,
                      ),
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

                    CustomTextformfeild(
                      controller: BlocProvider.of<SignupCubit>(context).Email,
                      formKey: BlocProvider.of<SignupCubit>(context).usernamekey,
                      textfeild: AppTexts.email,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: null,
                      obscureText: false,
                      validator: (p0) =>
                          BlocProvider.of<SignupCubit>(context).Validatorname(p0),
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                    CustomTextformfeild(
                      controller: BlocProvider.of<SignupCubit>(context).Password,
                      formKey: BlocProvider.of<SignupCubit>(context).Passwordkey,
                      textfeild: AppTexts.password,
                      keyboardType: TextInputType.text,
                      suffixIcon:GestureDetector(
                          onTap:() =>  BlocProvider.of<SignupCubit>(context).hidepass()
                          
                          ,child:BlocProvider.of<SignupCubit>(context).Pass==true ?
                      Icon(CupertinoIcons.eye_slash_fill, color: AppColors.blue)

                        :Icon(CupertinoIcons.eye_fill, color: AppColors.blue),

                      ),
                      obscureText: BlocProvider.of<SignupCubit>(context).Pass,
                      validator: (p0) =>
                          BlocProvider.of<SignupCubit>(context).Validatorpass(p0),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                    CustomTextformfeild(
                      controller:
                      BlocProvider.of<SignupCubit>(context).Confirmpassword,
                      formKey: BlocProvider.of<SignupCubit>(context).Confirmpasswordkey,
                      textfeild: AppTexts.ConfirmPassword,
                      keyboardType: TextInputType.text,
                      suffixIcon: GestureDetector(
                        onTap:() =>  BlocProvider.of<SignupCubit>(context).hideconfirmpass()

                        ,child:BlocProvider.of<SignupCubit>(context).conPass==true ?
                      Icon(CupertinoIcons.eye_slash_fill, color: AppColors.blue)

                          :Icon(CupertinoIcons.eye_fill, color: AppColors.blue),

                      ),
                      obscureText:
                      BlocProvider.of<SignupCubit>(context).conPass,
                      validator: (p0) => BlocProvider.of<SignupCubit>(context).Validatorconfirmpass(p0),
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                    checkRow(
                      text: Text(""),
                      value: BlocProvider.of<SignupCubit>(context).Check,
                      onchange: (v) {
                        BlocProvider.of<SignupCubit>(context).Checkbox(context);
                      },
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),


                    buttonshare(
                      text: AppTexts.Signup,
                      onTap: () {
                        BlocProvider.of<SignupCubit>(context).Signup(context: context);


                      },
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),


                    Center(
                      child: Text(
                        AppTexts.orcontinue,
                        style: TextStyle(color: AppColors.orcontinue),
                      ),
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),


                    anotherlogin(
                     onTap2:() {
                       BlocProvider.of<SignupCubit>(context).signInWithGoogle();

                     } ,
                      onTap1: null,
                    ),


                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppTexts.donthaveaccount),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return loginscreen();
                                }));
                          },
                          child: Text(
                            AppTexts.Login,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
