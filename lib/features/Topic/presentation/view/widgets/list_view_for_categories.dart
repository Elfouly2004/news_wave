
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/utils/Appimages.dart';
import 'package:newsapp/features/Topic/presentation/view/widgets/getnews_categories.dart';

import '../../../../../core/utils/Appcolors.dart';
import '../../../../Bookmark/presentation/controller/book_mark_cubit.dart';
import '../../../../News/presentation/controller/get_top_headline/get_top_headline_cubit.dart';
import '../../../Data/category_model.dart';
import '../../controller/categories_cubit.dart';
import '../../controller/categories_state.dart';


class ListViewForCategories extends StatelessWidget {
  ListViewForCategories({super.key});
  // businessentertainmentgeneralhealthsciencesportstechnology

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        itemCount:BlocProvider.of<CategoriesCubit>(context).categories.length,

        itemBuilder: (c,index) {
          return  CategoryWidget(
            index: index,
            categoryModel: BlocProvider.of<CategoriesCubit>(context). categories[index],
          ) ;
        } );
  }
}
class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.categoryModel, required this.index});

  final CategoryModel categoryModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Fetch news for the selected category
        BlocProvider.of<TopHeadlineCubit>(context).
        getTopHeadline(
            category: categoryModel.name,
          index: index,
            bookmarksList: BlocProvider.of<BookMarkCubit>(context).bookMarks,

        );

        // Navigate to the GetnewsCategories page
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => GetnewsCategories(
              categoryModel: categoryModel,
              index: index,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(image: AssetImage(categoryModel.photo)),
            ),
            Text(
              categoryModel.name,
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

