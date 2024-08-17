
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/features/news/newspage.dart';
class logincontroller extends ChangeNotifier{


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
       notifyListeners();
  }

  errormessage({required context})async{


    if(
    Username.currentState!.validate()==true
     && Password.currentState!.validate()==true
    ){

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return newspage();
      },));



    }


    notifyListeners();
  }

  hidepass(){
    pass=!pass;
    notifyListeners();
  }






}



