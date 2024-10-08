import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    loadImageUrl();
  }

  Future<void> loadImageUrl() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cachedImageUrl = prefs.getString('userImageUrl');
    });
  }

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
            ? FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').get(),
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

            final data = snapshot.data!.docs.first;
            final imageUrl = data['imageurl'] ?? "";

            // Save the image URL locally
            saveImageUrl(imageUrl);

            return CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.white,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        )
            : CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.white,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: cachedImageUrl!,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              ),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
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
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
            icon: Icon(Icons.settings, size: 30),
          )
        ],
      ),
    );
  }
}
