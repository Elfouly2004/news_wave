
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../News/Data/Model/News_model.dart';
import 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkStates> {
  BookMarkCubit() : super(BookMarkInitialState());




  changeBookMark( NewsModel newModel) {
    newModel.bookMark =!newModel.bookMark;
    if(newModel.bookMark)  {
      addToBookMarks(newModel: newModel);

    }else{
      removeToBookMarks(newModel: newModel);

    }
    emit(ChangeBookMarksColor());
  }

  List<NewsModel>  bookMarks =[ ];

  addToBookMarks(  {
    required  NewsModel newModel
  }){
    bookMarks.add(newModel);


  }
  removeToBookMarks ({required NewsModel newModel}) {

    bookMarks.remove(newModel);


  }
}
