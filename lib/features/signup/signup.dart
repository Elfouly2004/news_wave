import 'package:flutter/material.dart';
import 'package:newsapp/features/Fill%20Profile/fillprofile.dart';
import 'package:newsapp/features/login/login.dart';
import 'package:newsapp/features/signup/controller/signupcontroller.dart';
import 'package:newsapp/sharedwidget/Custom_Appbar.dart';
import 'package:provider/provider.dart';
import '../../core/utils/Appcolors.dart';
import '../../core/utils/Appimages.dart';
import '../../core/utils/Apptexts.dart';
import '../../sharedwidget/Custom_textformfeild.dart';
import '../../sharedwidget/anotherlogin.dart';
import '../../sharedwidget/button.dart';
import '../../sharedwidget/checkRow.dart';
class signup extends StatelessWidget {
signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Custom_Appbar(
        height: MediaQuery.sizeOf(context).height*0.8,
        widget: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Column(
          children: [

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02,),

            Center(
                child: Image(
                  image:AssetImage(AppImages.signup),
                  height:MediaQuery.sizeOf(context).height*0.04,
                  width:MediaQuery.sizeOf(context).height*0.1 ,
                )
            ),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.03,),

            CustomTextformfeild(
              key: Provider.of<signupcontroller>(context).key1,
              textfeild: AppTexts.username,
                keyboardType: TextInputType.name,
                suffixIcon: null,
                obscureText: false,
                validator: (p0) => Provider.of<signupcontroller>(context,listen: false).Validatorname(p0),
            ),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

            CustomTextformfeild(
              key: Provider.of<signupcontroller>(context).key2,
              textfeild: AppTexts.password,
              keyboardType: TextInputType. number,
              suffixIcon:  IconButton(
                onPressed: () {
                  Provider.of<signupcontroller>(context,listen: false).hidepass();
                },
                icon: Icon(Icons.remove_red_eye_rounded),
                color: AppColors.blue,
              ),
              obscureText:Provider.of<signupcontroller>(context,listen: false).Pass,
              validator: (p0) => Provider.of<signupcontroller>(context,listen: false).Validatorpass(p0),
            ),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

            CustomTextformfeild(
              key: Provider.of<signupcontroller>(context).key3,
              textfeild: AppTexts.ConfirmPassword,
              keyboardType: TextInputType.number,
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<signupcontroller>(context,listen: false).hideconfirmpass();
                },
                icon: Icon(Icons.remove_red_eye_rounded),
                color: AppColors.blue,
              ),
              obscureText:  Provider.of<signupcontroller>(context,).conPass,
              validator: (p0) => Provider.of<signupcontroller>(context,listen: false).Validatorconfirmpass(p0),
            ),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

            checkRow(text: Text(""),
              value: Provider.of<signupcontroller>(context).Check,
              onchange: (v) {
              Provider.of<signupcontroller>(context,listen: false).Checkbox(context);
            },),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

            buttonshare(text: AppTexts.Signup, onTap: () {
              Provider.of<signupcontroller>(context,listen: false).Errormessage(context: context);

            },),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02,),


            Center(
              child: Text(
                AppTexts.orcontinue,
                style: TextStyle(
                    color: AppColors.orcontinue
                ),
              ),
            ),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.02,),

            anotherlogin(),

            SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(AppTexts.donthaveaccount),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return fillprofile();
                      },));
                    },
                    child: Text(AppTexts.Login,style: TextStyle(fontSize: 14,color:  AppColors.blue,fontWeight: FontWeight.w600),))

              ],
            )
          ],

          ),
        ),
      ),
    );
  }
}
