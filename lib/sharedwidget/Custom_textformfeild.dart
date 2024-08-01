import 'package:flutter/material.dart';

class  CustomTextformfeild extends StatelessWidget {
  CustomTextformfeild
      ({
    required this.textfeild,
    required this.keyboardType,
    required this .suffixIcon,
    required this.obscureText,
    required this.key,
    required this.validator
  }
  );
final textfeild;
final TextInputType? keyboardType;
final Widget? suffixIcon;
final bool obscureText;
final Key? key;
final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("${textfeild}"),

            Container(
              width: 379,
              child: Form(
                key: key ,
                child: TextFormField(
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
