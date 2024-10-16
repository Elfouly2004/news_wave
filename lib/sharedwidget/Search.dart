
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/utils/Appcolors.dart';

class Search_feild extends StatelessWidget {
  const Search_feild({super.key, this.onChanged});
final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onChanged:onChanged ,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: AppColors.blue, fontSize: 20),
          prefixIcon: Icon(CupertinoIcons.search, size: 30, color: AppColors.blue),
          border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blue)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blue)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blue)),
        ),
      ),
    );
  }
}
