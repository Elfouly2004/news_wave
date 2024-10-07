


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../signup/presentation/controller/signup_cubit.dart';
import 'fillprofile_states.dart';
class FillprofileCubit extends Cubit<FillprofileStates> {
  FillprofileCubit() :super(FillprofileInitialState());



  TextEditingController fullname = TextEditingController();
  TextEditingController Emailaddress = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  GlobalKey<FormState> key1= GlobalKey <FormState>();
  GlobalKey<FormState> key2= GlobalKey <FormState>();
  GlobalKey<FormState> key3= GlobalKey <FormState>();



  XFile ? myPhoto ;
  // myPhoto = null ;
  Future<XFile?> pickImage() async{
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;

  }

  choosephoto(){

    pickImage().then((value) {
      emit(FillprofileuccessState());
      myPhoto=value;
    },);



  }


  Future<String> uploadImageToFirebase(File imageFile) async {

    // Check if the file exists
    if (!imageFile.existsSync()) {
      throw Exception("File does not exist: ${imageFile.path}");
    }

    // Reference for Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;

    // Retrieve the download URL for the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('Image uploaded successfully. URL: $downloadUrl');
    return downloadUrl;

  }



  Fillproile_Done({ context}) async {
    if (key1.currentState!.validate() &&
        key2.currentState!.validate() &&
        key3.currentState!.validate()) {

      emit(FillprofileLoadingState());

      try {
        // Ensure that an image is selected
        if (myPhoto == null) {
          emit(FillprofileFailureState(errorMessage: "No image selected"));
          return;
        }


        String imageUrl = await uploadImageToFirebase(File(myPhoto!.path));

        // If the image URL is empty, stop the process
        if (imageUrl.isEmpty) {
          emit(FillprofileFailureState(errorMessage: "Image upload failed"));
          return;
        }

        var userId = BlocProvider.of<SignupCubit>(context).userid.toString();


        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'imageurl': imageUrl,
          'FullName': fullname.text.trim(),
          'Email': Emailaddress.text.trim(),
          'PhoneNumber': phonenumber.text.trim(),
        });

        emit(FillprofilFinishState());

        String? full = fullname.text.trim();
        String? email =Emailaddress.text.trim();
        String? phone =phonenumber.text.trim();
        String? photo =myPhoto!.path;
        if( email.isNotEmpty&&full.isNotEmpty &&phone.isNotEmpty&&photo.isNotEmpty){
          fullname.clear();
          Emailaddress.clear();
          phonenumber.clear();
          myPhoto=null;
        }
        // Clear form fields
        fullname.clear();
        Emailaddress.clear();
        phonenumber.clear();
        myPhoto = null;
      } catch (e) {
        print('Error updating Firestore: $e');
        emit(FillprofileFailureState(errorMessage: e.toString()));
      }
    }
  }



  Future<void> fetchUserProfileData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;

        fullname.text = data['FullName'] ?? '';
        Emailaddress.text = data['Email'] ?? '';
        phonenumber.text = data['PhoneNumber'] ?? '';

        emit(FillprofileuccessState());
      }
    } catch (e) {
      emit(FillprofileFailureState(errorMessage: e.toString()));
    }
  }


  Validatorname(value) {


    if (value!.isEmpty || value == null) {
      emit(FillprofileuccessState());
      return (" 🚫 Please write full Name");
    } else {
      return null;
    }
  }

  ValidatorEmail(value) {

    if (value!.isEmpty || value == null) {
      emit(FillprofileuccessState());
      return ("🚫 write your Email");
    }
    else {
      return null;
    }
  }


  ValidatorNumber(value) {
    if (value!.isEmpty || value == null) {
      emit(FillprofileuccessState());
      return ("🚫 Write Phone Number");
    }
    return null;;
  }


// FillprofileModel? getProfile() {
//   var box = Hive.box<FillprofileModel>("ProfileBox");
//   return box.get("User");
//
//
// }







// Future<void> savePerson() async {
//   final box = Hive.box<FillprofileModel>('ProfileBox');
//   final persondata = FillprofileModel(
//       pic: myPhoto!.path,
//       Fullname: fullname.text,
//       Email: Emailaddress.text,
//       phonenumber: phonenumber.text
//   );
//   await box.put("Data",persondata);
//
// }



}
