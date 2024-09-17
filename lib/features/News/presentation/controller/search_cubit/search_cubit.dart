import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/News/presentation/controller/search_cubit/search_state.dart';

import '../../../Data/Model/News_model.dart';
import '../../../Data/Repo/home_repo.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(
      {
        required this.homeRepo
      }
      ) : super(GetSearchInitialState());


  final HomeRepo  homeRepo;



  List<NewsModel> searchNews = [] ;

  Future<void>     getSearch(
      {
        required  String q
      }
      )  async{
    print("start get top headline");
    emit(GetSearchLoadingState());
    var result  = await homeRepo.searchForNews(
      q: q,
    );
    result.fold( ( left) {
      print("result is: ${left.message}   ");

      emit(GetSearchFailureState(
          errorMessage: left.message
      ));

    },(right) {
      searchNews = right;

      emit(GetSearchSuccessState());

    } );

  }






}