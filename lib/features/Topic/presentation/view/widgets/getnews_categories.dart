import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/Appcolors.dart';
import '../../../../../sharedwidget/Search.dart';
import '../../../../News/presentation/controller/get_top_headline/get_top_headline_cubit.dart';
import '../../../../News/presentation/controller/get_top_headline/get_top_headline_states.dart';
import '../../../../News/presentation/view/list_veiw_news.dart';
import '../../../Data/category_model.dart';

class GetnewsCategories extends StatelessWidget {
  const GetnewsCategories({
    super.key,
    required this.categoryModel,
    required this.index
  });

  final CategoryModel categoryModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(categoryModel.name),
          elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Search_feild()),
      ),
      body: BlocBuilder<TopHeadlineCubit, TopHeadlineStates>(
        builder: (context, state) {
          if (state is GetTopHeadlineLoadingState) {
            // Show loading indicator
            return const Center(child: CircularProgressIndicator(
              color: AppColors.blue,
            ));
          } else if (state is GetTopHeadlineFailureState) {
            // Show error message
            return Center(child: Text(state.errorMessage));
          } else if (state is GetTopHeadlineSuccessState) {
            // Fetch the top headlines and display them
            var topHeadlines = BlocProvider.of<TopHeadlineCubit>(context).topHeadlines;
            return ListViewForNews(news: topHeadlines);
          } else {
            // Fallback UI if no news available
            return const Center(child: Text("No news available"));
          }
        },
      ),
    );
  }
}
