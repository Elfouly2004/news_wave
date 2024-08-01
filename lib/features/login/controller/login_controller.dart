
import 'package:flutter/material.dart';
import 'package:newsapp/features/news/newspage.dart';
class logincontroller extends ChangeNotifier{



  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey1= GlobalKey <FormState>();
  GlobalKey<FormState> formkey2= GlobalKey <FormState>();


  bool pass = false;
  bool check =false;

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

  errormessage({required context}){
    if(formkey1.currentState!.validate()==true && formkey2.currentState!.validate()==true){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return newspage();
      },
      )
      );
    }
    
    notifyListeners();
  }

  hidepass(){
    pass=!pass;
    notifyListeners();
  }






}



