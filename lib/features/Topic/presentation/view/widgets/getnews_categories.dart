import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/Appcolors.dart';
import '../../../../../sharedwidget/Search.dart';
import '../../../../News/Data/Model/News_model.dart';
import '../../../../News/presentation/controller/get_top_headline/get_top_headline_cubit.dart';
import '../../../../News/presentation/controller/get_top_headline/get_top_headline_states.dart';
import '../../../../News/presentation/controller/search_cubit/search_cubit.dart';
import '../../../../News/presentation/controller/search_cubit/search_state.dart';
import '../../../../News/presentation/view/list_veiw_news.dart';
import '../../../Data/category_model.dart';
import '../../controller/categories_cubit.dart';

class GetnewsCategories extends StatefulWidget {
  const GetnewsCategories({
    super.key,
    required this.categoryModel,
    required this.index
  });

  final CategoryModel categoryModel;
  final int index;

  @override
  State<GetnewsCategories> createState() => _GetnewsCategoriesState();
}

class _GetnewsCategoriesState extends State<GetnewsCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(widget.categoryModel.name),
          elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child:           BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, state) {


                return Padding(
                  padding: const EdgeInsets. all( 10),
                  child: Search_feild(
                    onChanged: (Q) {
                      BlocProvider.of<SearchCubit>(context).getSearch(q:  Q.trim());
                    },
                  ),
                ); // Default widget when no state matches
              },
            ),),
      ),
      body: BlocBuilder<TopHeadlineCubit, TopHeadlineStates>(
        builder: (context, state) {

          int key=BlocProvider.of<CategoriesCubit>(context).categoryIndex;
          List<NewsModel>?news=BlocProvider.of<TopHeadlineCubit>(context).mapfornews[key];


          if (state is GetTopHeadlineLoadingState &&news==null ||state is GetTopHeadlineLoadingState&&news!.isEmpty) {
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
            return const Center(child: Text(""));
          }
        },
      ),
    );
  }
}
