
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class fillprofilecontroller extends ChangeNotifier{




  TextEditingController fullname = TextEditingController();
  TextEditingController Emailaddress = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  GlobalKey<FormState> formkey1= GlobalKey <FormState>();
  GlobalKey<FormState> formkey2= GlobalKey <FormState>();
  GlobalKey<FormState> formkey3= GlobalKey <FormState>();


  XFile ? myPhoto ;
  // myPhoto = null ;
  Future<XFile?> pickImage() async{
    ImagePicker picker = ImagePicker();
    notifyListeners();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;

  }
choosephoto(){
  pickImage().then((value) {
    myPhoto=value;
  },);
  notifyListeners();
}







}