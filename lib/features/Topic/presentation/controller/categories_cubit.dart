
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/Appimages.dart';
import '../../Data/category_model.dart';
import 'categories_state.dart';


class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitial());

  final List<CategoryModel> categories = [

    CategoryModel(name: "Technology",photo: AppImages.technology),
    CategoryModel(name: "Sports",photo: AppImages.Sports),
    CategoryModel(name: "Business",photo: AppImages.business),
    CategoryModel(name: "Science",photo: AppImages.sience),
    CategoryModel(name: "General",photo: AppImages.General),

  ];

  int categoryIndex = 0 ;
  changeIndex( int index ) {
    categoryIndex = index ;
    emit(ChangeColorState());
  }

}
