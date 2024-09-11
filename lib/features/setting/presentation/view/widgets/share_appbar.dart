import 'package:flutter/material.dart';
class ShareAppbar extends StatelessWidget {
  const ShareAppbar({super.key, this.leading, this.title, this.actions});



  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AppBar(
        toolbarHeight:MediaQuery.sizeOf(context).height*0.3,

        leading: leading,

       centerTitle: true,

       title:title ,

        actions:actions ,

      ),
    );
  }
}
