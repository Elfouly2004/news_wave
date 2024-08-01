import 'package:flutter/material.dart';

import '../../news/newspage.dart';
class signupcontroller extends ChangeNotifier {


  TextEditingController Username = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Confirmpassword = TextEditingController();

  GlobalKey<FormState> key1 = GlobalKey <FormState>();
  GlobalKey<FormState> key2 = GlobalKey <FormState>();
  GlobalKey<FormState> key3 = GlobalKey <FormState>();


  bool Pass = false;
  bool Check = false;
  bool conPass = false;

  Validatorname(value) {
    if (value!.isEmpty || value == null) {
      return ("Invalid Username");
    } else {
      return null;
    }
  }

  Validatorpass(value) {
    if (value!.isEmpty || value == null) {
      return ("Password error");
    }
    else {
      return null;
    }
  }


  Validatorconfirmpass(value) {
    if (value!.isEmpty || value == null) {
      return ("write cofirm pass");
    }
    else {
      return null;
    }
  }


  Checkbox(v) {
    Check = !Check;
    notifyListeners();
  }

  Errormessage({required context}) {
    if (
        key1.currentState!.validate() == true
        &&
        key2.currentState!.validate() == true
        &&
        key3.currentState!.validate() == true
    ) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return newspage();
      },
      )
      );
    }

    notifyListeners();
  }

  hidepass() {
    Pass = !Pass;
    notifyListeners();
  }


  hideconfirmpass() {
    conPass =! conPass;
    notifyListeners();
  }

}