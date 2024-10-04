



import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news/presentation/view/home_screen.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() :super(LoginInitialState());

  bool pass = false;
  bool check =false;

  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();


  GlobalKey<FormState> Username= GlobalKey <FormState>();
  GlobalKey<FormState> Password= GlobalKey <FormState>();



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


        String? email = Email.text.trim();
        String? pass =password.text.trim();
        if( email.isNotEmpty&&pass.isNotEmpty ){
          Email.clear();
          password.clear();
        }



      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginFailureState(errorMessage: "user-not-found"));
        } else if (e.code == 'wrong-password') {
          emit(LoginFailureState(errorMessage: "wrong-password"));
        }else{
          emit(LoginFailureState(errorMessage: "Email or password was wrong"));
        }
      }on SocketException {
        emit(LoginFailureState(errorMessage: "Error Auth :  No Internet}"));

      } catch (e) {
        emit(LoginFailureState(
            errorMessage: "Oops An Eccurred error ${e.toString()}"));
        print(e.toString());
      }


    }
  }




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

    emit(LogincheckboxState());

  }
  hidepass(){


    pass=!pass;
    print("${pass}");
    emit(LoginSuccessState());


  }


}

