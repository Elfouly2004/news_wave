import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/features/Editprofile/presentation/view/editprofile.dart';
import 'package:newsapp/features/setting/presentation/view/setting.dart';
import 'package:newsapp/features/setting/presentation/view/widgets/share_appbar.dart';
import 'package:newsapp/features/setting/presentation/view/widgets/share_listile.dart';
import 'package:firebase_auth/firebase_auth.dart'; // لإضافة FirebaseAuth

import '../../../../core/utils/Appcolors.dart';
import '../../../../core/utils/Apptexts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب الـ uid للمستخدم الحالي
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
      // جلب بيانات المستخدم بناءً على uid الخاص به
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('No user data found.'));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ShareAppbar(
              leading: IconButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                ),
                icon: Icon(CupertinoIcons.arrow_left, size: 30),
              ),
              title: Text(
                AppTexts.profile,
                style: GoogleFonts.acme(),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Editprofile(
                        Email: data["email"], // لاحظ تغيير المفتاح إلى "email"
                        Fullname: data["FullName"],
                        phone: data["PhoneNumber"],
                      ),
                    ),
                  ),
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.blue, width: 4),
                    ),
                    child: data['imageurl'] == null
                        ? Icon(Icons.photo)
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        data["imageurl"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                ShareListile(
                  text2: "*",
                  text: AppTexts.fullname,
                  title: Text(data['FullName']),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                ShareListile(
                  text2: "*",
                  text: AppTexts.Email,
                  title: Text(data['email']),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                ShareListile(
                  text2: "*",
                  text: AppTexts.Phone,
                  title: Text(data['PhoneNumber']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
