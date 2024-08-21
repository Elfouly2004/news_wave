



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news/newspage.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() :super(LoginInitialState());

  bool pass = false;
  bool check =false;

  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();


  GlobalKey<FormState> Username= GlobalKey <FormState>();
  GlobalKey<FormState> Password= GlobalKey <FormState>();




  validatorname(value){
    if(value!.isEmpty||value==null){
      return ("Invalid Username");

    } else{
      return null;
    }  }

  validatorpass(value){
    if(value!.isEmpty||value==null){

      return("Password error");

    }
    else{
      return null;

    }
  }

  checkbox(v){

    check=!check;

    emit(LoginSuccessState());

  }

  Login({required context})async{

       emit(LoginLoadingState());

    if(
    Username.currentState!.validate()==true
        && Password.currentState!.validate()==true
    ){

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email.text.trim(),
          password: password.text.trim(),
        );
        emit(LoginSuccessState());
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return newspage();
        },));
        String? email = Email.text.trim();
        String? pass =password.text.trim();
        if( email.isNotEmpty&&pass.isNotEmpty ){
          Email.clear();
          password.clear();
        }


      }on FirebaseAuthException catch (e) {

        if (e.code == 'wrong-password') {
          emit(LoginFailureState(errorMessage: "The password is incorrect."));
        } else if (e.code == 'user-not-found') {
          emit(LoginFailureState(errorMessage: "No user found for that email."));
        } else if (e.code == 'invalid-email') {
          emit(LoginFailureState(
              errorMessage: "The email address is not valid."));
        } else {
          emit(LoginFailureState(
              errorMessage: "An unexpected error occurred"));
          print("${e.code}---------Elfouly");
        }
      } catch (e) {
        emit(LoginFailureState(
            errorMessage: "Oops, an unexpected error occurred: ${e.toString()}"));
        print(e);
      }
    } else {
      emit(LoginFailureState(errorMessage: "Check your data"));
    }
  }



  hidepass(){


    pass=!pass;
    print("${pass}");
    emit(LoginSuccessState());


  }


}

