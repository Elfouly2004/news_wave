

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/features/Fill%20Profile/presentation/controller/fillprofile_states.dart';

import '../../../news/presentation/view/news_screen.dart';
import '../../Data/model/fillprofile_model.dart';
class FillprofileCubit extends Cubit<FillprofileStates> {
  FillprofileCubit() :super(FillprofileInitialState());



  TextEditingController fullname = TextEditingController();
  TextEditingController Emailaddress = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  GlobalKey<FormState> key1= GlobalKey <FormState>();
  GlobalKey<FormState> key2= GlobalKey <FormState>();
  GlobalKey<FormState> key3= GlobalKey <FormState>();

  // List<FillprofileModel> profile=[];

  XFile ? myPhoto ;
  // myPhoto = null ;
  Future<XFile?> pickImage() async{
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;

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


  Fillproile_Done({context}){

    if( key1.currentState!.validate() == true
        && key2.currentState!.validate() == true
        && key3.currentState!.validate() == true)
    {



      Navigator.push(context, MaterialPageRoute(builder: (context) => newspage(),));

      emit(FillprofileuccessState());
    }
  }

  Future<void> savePerson() async {
    final box = Hive.box<FillprofileModel>('ProfileBox');
    final persondata = FillprofileModel(
        pic: myPhoto!.path,
        Fullname: fullname.text,
        Email: Emailaddress.text,
        phonenumber: phonenumber.text
    );
    await box.put("Data",persondata);

    // print("values is ==${box.get("Data")?.phonenumber}");
    // print("values is ==${box.get("Data")?.pic}");
    // print("values is ==${box.get("Data")?.Email}");
    // print("values is ==${box.get("Data")?.Fullname}");
  }



  choosephoto(){

    pickImage().then((value) {
      emit(FillprofileuccessState());
      myPhoto=value;
    },);



  }




    FillprofileModel? getProfile() {
      var box = Hive.box<FillprofileModel>("ProfileBox");
      return box.get("User");


    }







}
