


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/signup/presentation/controller/signup_states.dart';

import '../../../Fill Profile/presentation/view/fillprofile.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() :super(SignupInitialState());

String? userid;

  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final TextEditingController Confirmpassword = TextEditingController();

  GlobalKey<FormState> usernamekey = GlobalKey <FormState>();
  GlobalKey<FormState> Passwordkey = GlobalKey <FormState>();
  GlobalKey<FormState> Confirmpasswordkey = GlobalKey <FormState>();



  bool Pass = false;
  bool Check = false;
  bool conPass = false;





  Signup({required context}) async{



    if (
    usernamekey.currentState!.validate() == true
        && Passwordkey.currentState!.validate() == true
        && Confirmpasswordkey.currentState!.validate() == true


    ) {
      emit(SignupLoadingState());

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Email.text.trim(),
          password: Password.text.trim(),
        );

      userid=credential.user!.uid;

        await FirebaseFirestore.instance.collection('users').doc(userid).set({
          'email': Email.text.trim(),
          'password': Password.text.trim(),
          'userId': userid,
        });


        emit(SignupFinishState());



        String? email = Email.text.trim();
        String? pass =Password.text.trim();
        String? confirmpass =Confirmpassword.text.trim();

        if( email.isNotEmpty&&pass.isNotEmpty &&confirmpass.isNotEmpty){
          Email.text="";
          Password.text="";
          Confirmpassword.text="";
        }



      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(SignupFailureState(errorMessage: "Weak password"));


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("The password provided is too weak.")));

        } else if (e.code == 'email-already-in-use') {
          emit(SignupFailureState(errorMessage: "Email Already In Use"));

        }else if(Password != Confirmpassword){
          emit(SignupFailureState(errorMessage: "password not same Confirmpassowrd"));

        }
      } catch (e) {
        emit(SignupFailureState(
            errorMessage: "Oops, An Occurred Error ${e.toString()}"

        ));
        print(e);
      }

    }





  }




  Validatorname(value) {
    if (value!.isEmpty || value == null) {
      return (" 🚫 Invalid Email");
    } else {
      return null;
    }
  }

  Validatorpass(value) {
    if (value!.isEmpty || value == null) {
      return ("🚫 Password error");
    }
    else {
      return null;
    }
  }


  Validatorconfirmpass(value) {
    if (value!.isEmpty || value == null) {
      return ("🚫 write cofirm pass");
    }
    else if(Password.text!=Confirmpassword.text){
      return ("🚫 password not same Confirmpassword");;
    }
  }

  Checkbox(v) {
    Check = !Check;
    emit(SignupSuccessState());

  }

  hidepass() {
    Pass = !Pass;
    emit(SignupSuccessState());
  }


  hideconfirmpass() {
    conPass =! conPass;
    emit(SignupSuccessState());

  }



}

