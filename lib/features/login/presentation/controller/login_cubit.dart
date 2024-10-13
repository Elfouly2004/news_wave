



import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Fill Profile/presentation/controller/fillprofile_cubit.dart';
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



  Future<void> login({required BuildContext context}) async {
    emit(LoginLoadingState());

    if (Email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email.text.trim(),
          password: password.text.trim(),
        );

        String userId = credential.user!.uid;

        // Fetch and display the user's profile data
        BlocProvider.of<FillprofileCubit>(context).fetchUserProfileData(userId);

        emit(LoginSuccessState());


        String? email = Email.text.trim();
        String? pass =password.text.trim();
        if( email.isNotEmpty&&pass.isNotEmpty ){
          Email.clear();
          password.clear();
        }


      }  on FirebaseAuthException catch (e) {
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
        emit(LoginFailureState(errorMessage: e.toString()));
      }
    }



  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      emit(LoginLoadingState());

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in
      if (googleUser == null) {
        // Show a message if no account was signed in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No Google account was selected. Please try again.'),
          ),
        );

        emit(LoginGoogleFailureState(errorMessage:"No Google account selected "));
        return null; // Exit the function if sign-in is canceled
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      emit(LoginSuccessState());

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Show a message in case of an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during Google Sign-In: $e'),
        ),
      );

      emit(LoginGoogleFailureState(errorMessage: e.toString()));
      return null; // Return null in case of failure
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




//


//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../news/presentation/view/home_screen.dart';
// import 'login_states.dart';
//
// class LoginCubit extends Cubit<LoginStates> {
//   LoginCubit() :super(LoginInitialState());
//
//   bool pass = false;
//   bool check =false;
//
//   TextEditingController Email = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//
//   GlobalKey<FormState> Username= GlobalKey <FormState>();
//   GlobalKey<FormState> Password= GlobalKey <FormState>();
//
//
//
//   Login({required context})async{
//
//     emit(LoginLoadingState());
//
//     if(
//     Username.currentState!.validate()==true
//         && Password.currentState!.validate()==true
//     ){
//
//       try {
//         final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: Email.text.trim(),
//           password: password.text.trim(),
//         );
//
//         emit(LoginSuccessState());
//
//
//         String? email = Email.text.trim();
//         String? pass =password.text.trim();
//         if( email.isNotEmpty&&pass.isNotEmpty ){
//           Email.clear();
//           password.clear();
//         }
//
//
//
//       }
//       on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           emit(LoginFailureState(errorMessage: "user-not-found"));
//         } else if (e.code == 'wrong-password') {
//           emit(LoginFailureState(errorMessage: "wrong-password"));
//         }else{
//           emit(LoginFailureState(errorMessage: "Email or password was wrong"));
//         }
//       }on SocketException {
//         emit(LoginFailureState(errorMessage: "Error Auth :  No Internet}"));
//
//       } catch (e) {
//         emit(LoginFailureState(
//             errorMessage: "Oops An Eccurred error ${e.toString()}"));
//         print(e.toString());
//       }
//
//
//     }
//   }
//
//   Future<Map<String, dynamic>?> getUserData(String uid) async {
//     DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     return doc.data() as Map<String, dynamic>?;
//   }
//
//   Future<void> loginAndFetchUserData(String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       // استرجاع البيانات الشخصية للمستخدم
//       Map<String, dynamic>? userData = await getUserData(userCredential.user!.uid);
//       if (userData != null) {
//         print("User data: $userData");
//       }
//     } on FirebaseAuthException catch (e) {
//       print("Error: $e");
//     }
//   }
//
//
//
//   validatorname(value){
//     if(value!.isEmpty||value==null){
//       return ("Invalid Username");
//
//     } else{
//       return null;
//     }  }
//
//   validatorpass(value){
//     if(value!.isEmpty||value==null){
//
//       return("Password error");
//
//     }
//     else{
//       return null;
//
//     }
//   }
//
//   checkbox(v){
//
//     check=!check;
//
//     emit(LogincheckboxState());
//
//   }
//
//   hidepass(){
//
//
//     pass=!pass;
//     print("${pass}");
//     emit(LoginSuccessState());
//
//
//   }
//
//
// }



