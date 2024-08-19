import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/login/controller/login_cubit.dart';
import 'package:newsapp/features/signup/signup.dart';
import 'package:newsapp/sharedwidget/Custom_Appbar.dart';
import '../../core/utils/Appcolors.dart';
import '../../core/utils/Appimages.dart';
import '../../sharedwidget/Custom_textformfeild.dart';
import '../../sharedwidget/anotherlogin.dart';
import '../../sharedwidget/button.dart';
import '../../sharedwidget/checkRow.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
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
                controller: BlocProvider.of<LoginCubit>(context).username,
                formKey: BlocProvider.of<LoginCubit>(context).Username,
                textfeild: AppTexts.username,
                keyboardType: TextInputType.emailAddress,
                suffixIcon: null,
                obscureText: false,
                validator: (p0) => BlocProvider.of<LoginCubit>(context).validatorname(p0),


              ),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.01,),

              CustomTextformfeild(
                controller: BlocProvider.of<LoginCubit>(context).password,
                formKey:  BlocProvider.of<LoginCubit>(context).Password,
                  textfeild: AppTexts.password,
                keyboardType: TextInputType.number,
              obscureText: BlocProvider.of<LoginCubit>(context).pass,
              suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).hidepass();
                },
                icon: Icon(Icons.remove_red_eye_rounded),
                color: AppColors.blue,
              ),
                validator: (p0) =>BlocProvider.of<LoginCubit>(context).validatorpass(p0) ,



              ),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.01 ,),

              checkRow(
                text:  Text(
                  AppTexts.Forgotpassword,style: TextStyle(color: AppColors.blue),
                ),
                 value: BlocProvider.of<LoginCubit>(context).check,
                onchange: (v) {
setState(() {
  print("${BlocProvider.of<LoginCubit>(context).check}");
  BlocProvider.of<LoginCubit>(context).checkbox(context);
});

                },),

              SizedBox(height:MediaQuery.sizeOf(context).height*0.02 ,),

              buttonshare(text: AppTexts.Login, onTap: () {

                // Provider.of<logincontroller>(context,listen: false).loginfirebase();

                BlocProvider.of<LoginCubit>(context).
                  errormessage(context: context);

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
                    return Signup();
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
