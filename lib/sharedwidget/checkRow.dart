import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/login/presentation/controller/login_cubit.dart';


class checkRow extends StatelessWidget {
  const checkRow({required this.value,
    required this.onchange,
    required this .text,});
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

        TextButton(
          onPressed: () {

          FirebaseAuth.instance.
          sendPasswordResetEmail(email:BlocProvider.of<LoginCubit>(context).Email.text )
              .then((value) => print('Password reset email sent'))
              .catchError((error) => print('Failed to send password reset email: $error'));
         ;

        }, child:text,
        )

      ],
    );
  }
}
