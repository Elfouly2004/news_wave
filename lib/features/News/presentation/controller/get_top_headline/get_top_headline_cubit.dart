import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/News/presentation/controller/get_top_headline/get_top_headline_states.dart';
import '../../../Data/Model/News_model.dart';
import '../../../Data/Repo/home_repo.dart';



class TopHeadlineCubit extends Cubit<TopHeadlineStates> {

  TopHeadlineCubit({required this.homeRepo}) : super(GetTopHeadlineInitialState());


  final HomeRepo  homeRepo;



  List<NewsModel> topHeadlines = [] ;

  Future<void> getTopHeadline({String category = "technology"})  async{

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