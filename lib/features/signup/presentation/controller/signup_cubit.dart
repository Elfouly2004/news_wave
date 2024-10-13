


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/signup/presentation/controller/signup_states.dart';
import 'package:google_sign_in/google_sign_in.dart';
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





  Signup({required context}) async {
    if (usernamekey.currentState!.validate() &&
        Passwordkey.currentState!.validate() &&
        Confirmpasswordkey.currentState!.validate()) {
      emit(SignupLoadingState());

      try {
        // Create user in Firebase Authentication
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: Email.text.trim(),
          password: Password.text.trim(),
        );

        // Get user's uid
        userid = credential.user!.uid;

        // Save user's basic info in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userid).set({
          'Email': Email.text.trim(),
          'password': Password.text.trim(),
        });

        emit(SignupFinishState());

        // Clear fields after signup
        String? email = Email.text.trim();
        String? pass =Password.text.trim();
        String? confirm =Confirmpassword.text.trim();
        if( email.isNotEmpty&&pass.isNotEmpty&&confirm.isNotEmpty){
          Email.clear();
          Password.clear();
          Confirmpassword.clear();
        }

        // Navigate to fillprofile page to complete the profile

      } on FirebaseAuthException catch (e) {
        // Handle Firebase exceptions
        if (e.code == 'weak-password') {
          emit(SignupFailureState(errorMessage: "Weak password"));
        } else if (e.code == 'email-already-in-use') {
          emit(SignupFailureState(errorMessage: "Email already in use"));
        }
      } catch (e) {
        emit(SignupFailureState(
            errorMessage: "An error occurred: ${e.toString()}"));
      }
    }
  }



  Future<UserCredential> signInWithGoogle() async {
    emit(SignupLoadingState());

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Emit state for successful Google signup
    emit(SignupGoogleState());

    // Return the user credential object
    return userCredential;
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
    emit(SignupcheckboxState());

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




//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapp/features/signup/presentation/controller/signup_states.dart';
//
// import '../../../Fill Profile/presentation/view/fillprofile.dart';
//
// class SignupCubit extends Cubit<SignupStates> {
//   SignupCubit() :super(SignupInitialState());
//
//
//
//   final TextEditingController Email = TextEditingController();
//   final TextEditingController Password = TextEditingController();
//   final TextEditingController Confirmpassword = TextEditingController();
//
//   GlobalKey<FormState> usernamekey = GlobalKey <FormState>();
//   GlobalKey<FormState> Passwordkey = GlobalKey <FormState>();
//   GlobalKey<FormState> Confirmpasswordkey = GlobalKey <FormState>();
//
//
//
//   bool Pass = false;
//   bool Check = false;
//   bool conPass = false;
//
//
//
//
//
//   Signup({required context}) async{
//
//
//
//     if (
//     usernamekey.currentState!.validate() == true
//         && Passwordkey.currentState!.validate() == true
//         && Confirmpasswordkey.currentState!.validate() == true
//
//
//     ) {
//       emit(SignupLoadingState());
//
//       try {
//         final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: Email.text.trim(),
//           password: Password.text.trim(),
//         );
//
//
//         var userid=credential.user!.uid;
//
//         await FirebaseFirestore.instance.collection('users').doc(userid).set({
//           'email': Email.text.trim(),
//           'password': Password.text.trim(),
//           'userId': userid,
//         });
//
//
//         emit(SignupFinishState());
//
//
//
//         String? email = Email.text.trim();
//         String? pass =Password.text.trim();
//         String? confirmpass =Confirmpassword.text.trim();
//
//         if( email.isNotEmpty&&pass.isNotEmpty &&confirmpass.isNotEmpty){
//           Email.text="";
//           Password.text="";
//           Confirmpassword.text="";
//         }
//
//
//
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           emit(SignupFailureState(errorMessage: "Weak password"));
//
//
//           ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("The password provided is too weak.")));
//
//         } else if (e.code == 'email-already-in-use') {
//           emit(SignupFailureState(errorMessage: "Email Already In Use"));
//
//         }else if(Password != Confirmpassword){
//           emit(SignupFailureState(errorMessage: "password not same Confirmpassowrd"));
//
//         }
//       } catch (e) {
//         emit(SignupFailureState(
//             errorMessage: "Oops, An Occurred Error ${e.toString()}"
//
//         ));
//         print(e);
//       }
//
//     }
//
//
//
//
//
//   }
//
//
//   Future<void> saveUserData(String uid, String fullName, String phoneNumber, String imageUrl) async {
//     await FirebaseFirestore.instance.collection('users').doc(uid).set({
//       'fullName': fullName,
//       'email': Email,
//       'phoneNumber': phoneNumber,
//       'imageUrl': imageUrl,
//       'password': Password,
//     });
//   }
//
//   Future<void> signUpAndSaveData(
//       String fullName, String phoneNumber, String imageUrl) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: Email.text.toString(),
//         password: Password.text.trim(),
//       );
//
//       // احفظ البيانات الشخصية في Firestore
//       await saveUserData(userCredential.user!.uid, fullName, phoneNumber, imageUrl);
//       print("User data saved: ${userCredential.user!.uid}");
//     } on FirebaseAuthException catch (e) {
//       print("Error: $e");
//     }
//   }
//
//
//   Validatorname(value) {
//     if (value!.isEmpty || value == null) {
//       return (" 🚫 Invalid Email");
//     } else {
//       return null;
//     }
//   }
//
//   Validatorpass(value) {
//     if (value!.isEmpty || value == null) {
//       return ("🚫 Password error");
//     }
//     else {
//       return null;
//     }
//   }
//
//
//   Validatorconfirmpass(value) {
//     if (value!.isEmpty || value == null) {
//       return ("🚫 write cofirm pass");
//     }
//     else if(Password.text!=Confirmpassword.text){
//       return ("🚫 password not same Confirmpassword");;
//     }
//   }
//
//   Checkbox(v) {
//     Check = !Check;
//     emit(SignupcheckboxState());
//
//   }
//
//   hidepass() {
//     Pass = !Pass;
//     emit(SignupSuccessState());
//   }
//
//
//   hideconfirmpass() {
//     conPass =! conPass;
//     emit(SignupSuccessState());
//
//   }
//
//
// }


