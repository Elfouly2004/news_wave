import '../../../News/Data/Model/News_model.dart';

abstract class BookMarkStates {}

class BookMarkInitialState extends BookMarkStates {}

class ChangeBookMarksColor extends BookMarkStates {}

class BookMarksLoadedState extends BookMarkStates {
  final List<NewsModel> BookMarks;
  BookMarksLoadedState( this.BookMarks);}


class BookMarksErrorState extends BookMarkStates {
  final String error;
  BookMarksErrorState(this.error);
}
