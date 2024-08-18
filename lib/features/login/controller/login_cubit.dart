



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../news/newspage.dart';
import 'login_states.dart';

class RegisterCubit extends Cubit<LoginStates> {
  RegisterCubit() :super(LoginInitialState());

  bool pass = false;
  bool check =false;

  TextEditingController username = TextEditingController();
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

  }

  errormessage({required context})async{

       emit(LoginLoadingState());

    if(
    Username.currentState!.validate()==true
        && Password.currentState!.validate()==true
    ){

     emit(LoginSuccessState());

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return newspage();
      },));



    }else{
      emit(LoginFailureState(errorMessage: "Check your data"));
    }



  }

  hidepass(){
    pass=!pass;

  }


}