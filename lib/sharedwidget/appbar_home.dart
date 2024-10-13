


//لو عايز صوره اكونت جوجل

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart'; // إضافة المكتبة
import '../core/utils/Appcolors.dart';
import '../core/utils/Appimages.dart';
import '../features/setting/presentation/view/setting.dart';

class AppbarHome extends StatefulWidget {
  const AppbarHome({super.key});

  @override
  State<AppbarHome> createState() => _AppbarHomeState();
}

class _AppbarHomeState extends State<AppbarHome> {
  String? userId;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
  }

  Future<void> getCurrentUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });

      // التحقق من طريقة تسجيل الدخول
      if (user.providerData.any((info) => info.providerId == 'google.com')) {
        // إذا كان تسجيل الدخول عبر Google، استخدم الصورة المرتبطة بحساب Google
        setState(() {
          profileImageUrl = user.photoURL;
        });
      } else {
        // إذا كان تسجيل الدخول عبر البريد الإلكتروني، قم بتحميل الصورة من Firestore
        loadImageUrlFromFirestore(user.uid);
      }
    }
  }

  Future<void> loadImageUrlFromFirestore(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          profileImageUrl = data['imageurl'] ?? ""; // تحميل رابط الصورة من Firestore
        });
      }
    } catch (e) {
      print("Error loading image from Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        toolbarHeight: 120,
        leading: profileImageUrl != null && profileImageUrl!.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: profileImageUrl!,
            placeholder: (context, url) => const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: CircularProgressIndicator(color: AppColors.blue,), // عرض مؤشر تحميل أثناء انتظار تحميل الصورة
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error), // في حال فشل تحميل الصورة
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider, // الصورة المحملة
            ),
          ),
        )
            : const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent,
          child: CircularProgressIndicator(), // مؤشر تحميل في حالة عدم وجود الصورة
        ),
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 10),
            Image(
              image: AssetImage(AppImages.Newswavepic),
              height: 32,
              width: 93,
            ),
            const SizedBox(height: 10),
            Image(
              image: AssetImage(AppImages.Newswavetxt),
              height: 24,
              width: 144,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Setting()),
              );
            },
            icon: const Icon(Icons.settings, size: 30),
          ),
        ],
      ),
    );
  }
}





// //لو عايز الصوره االلي حاططها
//
//
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../core/utils/Appcolors.dart';
// import '../core/utils/Appimages.dart';
// import '../features/setting/presentation/view/setting.dart';
//
// class AppbarHome extends StatefulWidget {
//   const AppbarHome({super.key});
//
//   @override
//   State<AppbarHome> createState() => _AppbarHomeState();
// }
//
// class _AppbarHomeState extends State<AppbarHome> {
//   String? cachedImageUrl;
//   String? userId;
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUserId(); // الحصول على UID المستخدم النشط
//     loadImageUrl(); // تحميل الصورة المخزنة
//   }
//
//   // الحصول على UID المستخدم الحالي
//   Future<void> getCurrentUserId() async {
//     final User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         userId = user.uid;
//       });
//       loadImageUrlFromFirestore(user.uid); // جلب الصورة من Firestore باستخدام UID
//     }
//   }
//
//   // تحميل رابط الصورة من Firestore بناءً على UID
//   Future<void> loadImageUrlFromFirestore(String userId) async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
//       if (userDoc.exists) {
//         final data = userDoc.data() as Map<String, dynamic>;
//         final imageUrl = data['imageurl'] ?? "";
//
//         // إذا كانت الصورة موجودة، قم بحفظ الرابط محليًا
//         if (imageUrl.isNotEmpty) {
//           await saveImageUrl(imageUrl);
//           setState(() {
//             cachedImageUrl = imageUrl;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error loading image from Firestore: $e");
//     }
//   }
//
//   // تحميل رابط الصورة من SharedPreferences
//   Future<void> loadImageUrl() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       cachedImageUrl = prefs.getString('userImageUrl');
//     });
//   }
//
//   // حفظ رابط الصورة في SharedPreferences
//   Future<void> saveImageUrl(String imageUrl) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userImageUrl', imageUrl);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
//       child: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.white,
//         toolbarHeight: 120,
//         leading: cachedImageUrl == null
//             ? FutureBuilder<DocumentSnapshot>(
//           future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.blue,
//                 ),
//               );
//             }
//
//             if (!snapshot.hasData || !snapshot.data!.exists) {
//               return const Center(child: Icon(Icons.error));
//             }
//
//             final data = snapshot.data!.data() as Map<String, dynamic>;
//             final imageUrl = data['imageurl'] ?? "";
//
//             // حفظ رابط الصورة محليًا
//             saveImageUrl(imageUrl);
//
//             return CircleAvatar(
//               radius: 60,
//               backgroundColor: AppColors.white,
//               child: ClipOval(
//                 child: CachedNetworkImage(
//                   imageUrl: imageUrl,
//                   placeholder: (context, url) => Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.blue,
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           },
//         )
//             : CircleAvatar(
//           radius: 60,
//           backgroundColor: AppColors.white,
//           child: ClipOval(
//             child: CachedNetworkImage(
//               imageUrl: cachedImageUrl!,
//               placeholder: (context, url) => Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.blue,
//                 ),
//               ),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         centerTitle: true,
//
//         title: Column(
//           children: [
//             SizedBox(height: 10),
//             Image(
//               image: AssetImage(AppImages.Newswavepic),
//               height: 32,
//               width: 93,
//             ),
//             SizedBox(height: 10),
//             Image(
//               image: AssetImage(AppImages.Newswavetxt),
//               height: 24,
//               width: 144,
//             )
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Setting()),
//               );
//             },
//             icon: const Icon(Icons.settings, size: 30),
//           )
//         ],
//       ),
//     );
//   }
// }
