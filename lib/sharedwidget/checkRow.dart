import 'package:flutter/material.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/login/controller/login_controller.dart';
import 'package:newsapp/features/signup/signup.dart';
import 'package:provider/provider.dart';


class checkRow extends StatelessWidget {
  const checkRow({required this.value,required this.onchange,required this .text});
 final void Function(bool?) onchange;
 final bool? value;
 final text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            Checkbox(
              activeColor: AppColors.blue,
              value:value,
                onChanged: onchange
            ),

            Text(AppTexts.Rememberme),

          ],
        ),

        TextButton(onPressed: () {

          // Navigator.push(context, MaterialPageRoute(builder: (context) => signup(),));

        }, child:text,
        )

      ],
    );
  }
}
