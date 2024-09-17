import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/features/News/presentation/view/homebody.dart';
import 'package:newsapp/features/News/presentation/view/newswidet.dart';
import '../../Data/Model/News_model.dart';


class ListViewForNews extends StatelessWidget {
  const ListViewForNews({super.key, required this.news});
  final List<NewsModel> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index) {

      return  NewWidget(newModel: news[index]);
    } ,
      itemCount: news.length,
    );
  }
}