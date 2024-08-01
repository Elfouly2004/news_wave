import 'package:flutter/material.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/login/controller/login_controller.dart';
import 'package:newsapp/features/signup/signup.dart';
import 'package:newsapp/sharedwidget/Custom_Appbar.dart';
import 'package:provider/provider.dart';

import '../../core/utils/Appcolors.dart';
import '../../core/utils/Appimages.dart';
import '../../sharedwidget/Custom_textformfeild.dart';
import '../../sharedwidget/anotherlogin.dart';
import '../../sharedwidget/button.dart';
import '../../sharedwidget/checkRow.dart';
import '../news/newspage.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Custom_Appbar(
        height: MediaQuery.sizeOf(context).height*0.7,
        widget: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [


              Center(child: Image(image:AssetImage(AppImages.loginlogo),
                height:MediaQuery.sizeOf(context).height*0.04,
                width:MediaQuery.sizeOf(context).height*0.1 ,)),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.04 ,),

              CustomTextformfeild(
                key: Provider.of<logincontroller>(context).formkey1,
                textfeild: AppTexts.username,
                keyboardType: TextInputType.name,
                suffixIcon: null,
                obscureText: false,
                validator: (p0) => Provider.of<logincontroller>(context,listen: false).validatorname(p0),


              ),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

              CustomTextformfeild(
                key:  Provider.of<logincontroller>(context).formkey2,
                  textfeild: AppTexts.password,
                keyboardType: TextInputType.number,
              obscureText: Provider.of<logincontroller>(context).pass,
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<logincontroller>(context,listen: false).hidepass();
                },
                icon: Icon(Icons.remove_red_eye_rounded),
                color: AppColors.blue,
              ),
                validator: (p0) =>Provider.of<logincontroller>(context,listen: false).validatorpass(p0) ,



              ),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.01 ,),

              checkRow(
                text:  Text(
                  AppTexts.Forgotpassword,style: TextStyle(color: AppColors.blue),
                ),
                 value: Provider.of<logincontroller>(context).check,
                onchange: (v) {
                 Provider.of<logincontroller>(context,listen: false).checkbox(context);
                },),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

              buttonshare(text: AppTexts.Login, onTap: () {
                  Provider.of<logincontroller>(context,listen: false).errormessage(context: context);

                },),


              SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

              Center(
                child: Text(
             AppTexts.orcontinue,
                  style: TextStyle(
                    color: AppColors.orcontinue
                  ),
                ),
              ),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.03 ,),


              anotherlogin(),


              SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(AppTexts.donthaveaccount),
                  TextButton(
                    onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
           return signup();
          },));
                    },
                      child: Text(AppTexts.Signup,style: TextStyle(fontSize: 14,color:  AppColors.blue,fontWeight: FontWeight.w600),))

                ],
              )


            ],
          ),
        ),
      )

    );
  }
}
