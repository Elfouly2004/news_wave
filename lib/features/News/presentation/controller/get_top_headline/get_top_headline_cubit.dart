import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Data/Model/News_model.dart';
import '../../../Data/Repo/home_repo.dart';
import 'get_top_headline_states.dart';

class TopHeadlineCubit extends Cubit<TopHeadlineStates> {
  TopHeadlineCubit({required this.homeRepo}) : super(GetTopHeadlineInitialState());

  final HomeRepo  homeRepo;
  List<NewsModel> topHeadlines = [] ;

  Future<void> getTopHeadline({String category = "technology"}) async{

    print("start get top headline");

    emit(GetTopHeadlineLoadingState());

    var result  = await homeRepo.getTopHeadline(category: category);
    result.fold( ( left) {
      print("result is: ${left.message}   ");

      emit(GetTopHeadlineFailureState(
          errorMessage: left.message
      ));

    },(right) {
      topHeadlines = right;

      print("result is: $topHeadlines   ");
      emit(GetTopHeadlineSuccessState());

    } );

  }






}