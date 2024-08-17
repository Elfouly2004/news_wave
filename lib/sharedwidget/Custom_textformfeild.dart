import 'package:flutter/material.dart';
import 'package:newsapp/core/utils/Appcolors.dart';

class  CustomTextformfeild extends StatelessWidget {
  CustomTextformfeild
      ({
    required this.textfeild,
    required this.keyboardType,
    required this .suffixIcon,
    required this.obscureText,
    required this.formKey,
    required this.validator,
    required this.controller
  }
  );
final textfeild;
final TextInputType? keyboardType;
final Widget? suffixIcon;
final bool obscureText;
  final GlobalKey<FormState> formKey;
final TextEditingController? controller;
final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         RichText(
             text: TextSpan(
           text: textfeild,
           style: TextStyle(color: AppColors.black),
           children: [
             TextSpan(text:" *",style: TextStyle(color: Colors.red))
           ]
         )),


            Container(
              width: 379,
              child: Form(
                key: formKey ,
                child: TextFormField(
                  controller: controller,
                    autofocus: false,
                  obscureText: obscureText,

                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                      color: Colors.black,

                    ),
                    ),

                    iconColor: Colors.white,


                  ),

                  validator:validator
                    ),
              ),
            ),
          ],
        )
    );
  }
}
