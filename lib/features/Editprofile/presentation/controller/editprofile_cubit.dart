

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/features/Fill%20Profile/presentation/controller/fillprofile_states.dart';
import 'package:newsapp/features/signup/presentation/controller/signup_cubit.dart';
import '../../../Fill Profile/presentation/controller/fillprofile_cubit.dart';
import '../../../news/presentation/view/news_screen.dart';
import '../../../setting/presentation/view/profile.dart';
import 'editprofile_states.dart';
class EditprofileCubit extends Cubit<EditprofileStates> {
  EditprofileCubit() :super(EditprofileInitialState());



  TextEditingController Edit_fullname = TextEditingController();
  TextEditingController Edit_Emailaddress = TextEditingController();
  TextEditingController Edit_phonenumber = TextEditingController();





  XFile ? EditPhoto ;
  // myPhoto = null ;
  Future<XFile?> pickImage() async{
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;

  }

  choosephoto(){

    pickImage().then((value) {
      emit(EditprofileuccessState());
      EditPhoto=value;
    },);




  }


  Future<String> uploadImageToFirebase(File imageFile) async {

    final storageRef = FirebaseStorage.instance.ref()
        .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;

  }


  Editproile_Done(context)async{


      emit(EditprofileLoadingState());

      try {

        String imageUrl = await uploadImageToFirebase(File(EditPhoto!.path));


        var userId = BlocProvider.of<SignupCubit>(context).userid.toString();


        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'FullName': Edit_fullname.text,
          'Email': Edit_Emailaddress.text,
          'PhoneNumber': Edit_phonenumber.text,
          'imageurl': imageUrl,
        });

        emit(EditprofilFinishState());


      } catch (e) {

        emit(EditprofileFailureState(errorMessage: e.toString()));
      }

  }









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
