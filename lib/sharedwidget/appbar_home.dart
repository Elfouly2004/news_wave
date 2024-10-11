import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/utils/Appcolors.dart';
import '../core/utils/Appimages.dart';
import '../features/setting/presentation/view/setting.dart';

class AppbarHome extends StatefulWidget {
  const AppbarHome({super.key});

  @override
  State<AppbarHome> createState() => _AppbarHomeState();
}

class _AppbarHomeState extends State<AppbarHome> {
  String? cachedImageUrl;
  String? userId;

  @override
  void initState() {
    super.initState();
    getCurrentUserId(); // الحصول على UID المستخدم النشط
    loadImageUrl(); // تحميل الصورة المخزنة
  }

  // الحصول على UID المستخدم الحالي
  Future<void> getCurrentUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      loadImageUrlFromFirestore(user.uid); // جلب الصورة من Firestore باستخدام UID
    }
  }

  // تحميل رابط الصورة من Firestore بناءً على UID
  Future<void> loadImageUrlFromFirestore(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        final imageUrl = data['imageurl'] ?? "";

        // إذا كانت الصورة موجودة، قم بحفظ الرابط محليًا
        if (imageUrl.isNotEmpty) {
          await saveImageUrl(imageUrl);
          setState(() {
            cachedImageUrl = imageUrl;
          });
        }
      }
    } catch (e) {
      print("Error loading image from Firestore: $e");
    }
  }

  // تحميل رابط الصورة من SharedPreferences
  Future<void> loadImageUrl() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cachedImageUrl = prefs.getString('userImageUrl');
    });
  }

  // حفظ رابط الصورة في SharedPreferences
  Future<void> saveImageUrl(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImageUrl', imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        toolbarHeight: 120,
        leading: cachedImageUrl == null
            ? FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Icon(Icons.error));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final imageUrl = data['imageurl'] ?? "";

            // حفظ رابط الصورة محليًا
            saveImageUrl(imageUrl);

            return CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.white,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        )
            : CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.white,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: cachedImageUrl!,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,

        title: Column(
          children: [
            SizedBox(height: 10),
            Image(
              image: AssetImage(AppImages.Newswavepic),
              height: 32,
              width: 93,
            ),
            SizedBox(height: 10),
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
          )
        ],
      ),
    );
  }
}
