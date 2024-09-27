import 'package:flutter/material.dart';
import 'package:newsapp/features/Topic/presentation/view/widgets/list_view_for_categories.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Padding(
        padding: const EdgeInsets.all(10),
        child: ListViewForCategories(),
      )
      
    );
  }
}
