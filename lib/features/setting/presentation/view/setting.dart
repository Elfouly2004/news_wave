import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/core/utils/Apptexts.dart';
import 'package:newsapp/features/login/presentation/view/login.dart';
import 'package:newsapp/features/news/presentation/view/home_screen.dart';
import 'package:newsapp/features/setting/presentation/view/profile.dart';
import 'package:newsapp/features/setting/presentation/view/widgets/share_appbar.dart';
import 'package:newsapp/features/setting/presentation/view/widgets/share_listile.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: ShareAppbar(
            
            leading: IconButton(onPressed: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => newspage(),)) ,
                icon:Icon(CupertinoIcons.xmark,size: 30,)),
            
            title: Text(AppTexts.setting,style: GoogleFonts.acme(),),

      )
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),

            ShareListile(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));

              },
              leading: Icon(CupertinoIcons.lock,size: 30,color: AppColors.blue,),
               title: Text("Profile",style: TextStyle(fontWeight:FontWeight.bold ),),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));

                    },
                    icon: Icon(Icons.arrow_forward_ios,color: AppColors.blue,)),
            ),

            SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

            ShareListile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => loginscreen()),
                      (Route<dynamic> route) => false, // This removes all previous routes
                );
              },
              leading: Icon(
                Icons.logout_outlined,
                size: 30,
                color: Colors.red,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
