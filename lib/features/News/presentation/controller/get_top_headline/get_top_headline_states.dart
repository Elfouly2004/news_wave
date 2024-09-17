abstract class TopHeadlineStates{ }
class GetTopHeadlineInitialState extends TopHeadlineStates { }
class GetTopHeadlineLoadingState extends TopHeadlineStates { }
class GetTopHeadlineFailureState extends TopHeadlineStates {
  final String errorMessage ;
  GetTopHeadlineFailureState({required this.errorMessage}) ;
}
class GetTopHeadlineSuccessState extends TopHeadlineStates { }