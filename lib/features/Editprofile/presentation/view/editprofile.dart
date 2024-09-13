import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newsapp/features/Fill%20Profile/presentation/controller/fillprofile_cubit.dart';

import '../../../../core/utils/Appcolors.dart';
import '../../../../core/utils/Apptexts.dart';
import '../../../../sharedwidget/Custom_textformfeild.dart';
import '../../../setting/presentation/view/profile.dart';
import '../../../setting/presentation/view/widgets/share_appbar.dart';
import '../controller/editprofile_cubit.dart';
import '../controller/editprofile_states.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key, this.Fullname, this.Email, this.phone});

  final String? Fullname;
  final String? Email;
  final String? phone;

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<EditprofileCubit>(context);
    cubit.Edit_fullname.text = widget.Fullname ?? '';
    cubit.Edit_Emailaddress.text = widget.Email ?? '';
    cubit.Edit_phonenumber.text = widget.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditprofileCubit, EditprofileStates>(
      listener: (context, state) {
        if (state is EditprofilFinishState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          );
        }
      },
      builder: (context, state) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }


            final data = snapshot.data!.docs.first;
            final uid = data.id;

            return ModalProgressHUD(
              inAsyncCall: state is EditprofileLoadingState,
              progressIndicator: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: ShareAppbar(
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(CupertinoIcons.xmark, size: 25),
                    ),
                    title: Text(
                      AppTexts.editprofile,
                      style: GoogleFonts.acme(),
                    ),
                    actions: [

                    IconButton(
                            onPressed: () {
                              BlocProvider.of<EditprofileCubit>(context)
                                  .Editproile_Done(context, uid);
                            },
                            icon: Icon(CupertinoIcons.checkmark_alt, size: 30),

                      )
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                      BlocBuilder<EditprofileCubit, EditprofileStates>(
                        builder: (context, state) {
                          return Center(
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.blue,
                                      width: 2,
                                    ),
                                  ),
                                  child: BlocProvider.of<EditprofileCubit>(context)
                                      .EditPhoto ==
                                      null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: Image.network(
                                      data["imageurl"],
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: Image.file(
                                      File(
                                        BlocProvider.of<EditprofileCubit>(
                                            context)
                                            .EditPhoto!
                                            .path,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<EditprofileCubit>(context)
                                        .choosephoto();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.camera,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                      BlocBuilder<EditprofileCubit, EditprofileStates>(
                        builder: (context, state) {
                          return CustomTextformfeild(
                            controller:
                            BlocProvider.of<EditprofileCubit>(context)
                                .Edit_fullname,
                            formKey: null,
                            validator: null,
                            obscureText: false,
                            suffixIcon: null,
                            keyboardType: TextInputType.name,
                            textfeild: AppTexts.fullname,
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                      BlocBuilder<EditprofileCubit, EditprofileStates>(
                        builder: (context, state) {
                          return CustomTextformfeild(
                            controller:
                            BlocProvider.of<EditprofileCubit>(context)
                                .Edit_Emailaddress,
                            formKey: null,
                            validator: (p0) => null,
                            obscureText: false,
                            suffixIcon: null,
                            keyboardType: TextInputType.emailAddress,
                            textfeild: AppTexts.Email,
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                      BlocBuilder<EditprofileCubit, EditprofileStates>(
                        builder: (context, state) {
                          return CustomTextformfeild(
                            controller:
                            BlocProvider.of<EditprofileCubit>(context)
                                .Edit_phonenumber,
                            formKey: null,
                            validator: (p0) => null,
                            obscureText: false,
                            suffixIcon: null,
                            keyboardType: TextInputType.phone,
                            textfeild: AppTexts.Phone,
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
