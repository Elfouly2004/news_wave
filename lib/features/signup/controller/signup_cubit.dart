


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/Fill%20Profile/fillprofile.dart';
import 'package:newsapp/features/signup/controller/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() :super(SignupInitialState());



  final TextEditingController username = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final TextEditingController Confirmpassword = TextEditingController();

  GlobalKey<FormState> usernamekey = GlobalKey <FormState>();
  GlobalKey<FormState> Passwordkey = GlobalKey <FormState>();
  GlobalKey<FormState> Confirmpasswordkey = GlobalKey <FormState>();



  bool Pass = false;
  bool Check = false;
  bool conPass = false;

  Validatorname(value) {
    if (value!.isEmpty || value == null) {
      return (" 🚫 Invalid Username");
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
    else {
      return null;
    }
  }

  Checkbox(v) {
    Check = !Check;
    emit(SignupSuccessState());

  }

  Signup({required context}) async{



    if (
    usernamekey.currentState!.validate() == true
        && Passwordkey.currentState!.validate() == true
        && Confirmpasswordkey.currentState!.validate() == true

    ) {
      emit(SignupLoadingState());

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username.text.trim(),
          password: Password.text.trim(),
        );

        emit(SignupSuccessState());

        Navigator.push(context, MaterialPageRoute(builder: (context) => fillprofile(),));

        String? Username = username.text.trim();
        String? pass =Password.text.trim();
        String? confirmpass =Confirmpassword.text.trim();

        if( Username.isNotEmpty&&pass.isNotEmpty &&confirmpass.isNotEmpty){
          username.text="";
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
        }
      } catch (e) {
        emit(SignupFailureState(
            errorMessage: "Oops, An Occurred Error ${e.toString()}"

        ));
        print(e);
      }

    }





  }

  hidepass() {
    Pass = !Pass;
  }


  hideconfirmpass() {
    conPass =! conPass;

  }



}

