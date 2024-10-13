import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../News/Data/Model/News_model.dart';
import 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkStates> {
  BookMarkCubit() : super(BookMarkInitialState());

  List<NewsModel> bookMarks = [];
  var box = Hive.box<NewsModel>("Saved_newsBox");

  // تغيير حالة العلامة المرجعية (bookMark)
  void changeBookMark(NewsModel newModel) {
    newModel.bookMark = !newModel.bookMark;

    if (newModel.bookMark) {
      addToBookMarks(newModel: newModel);

    } else {
      removeToBookMarks(newModel: newModel);

    }
    // saveBookmarks();
    emit(ChangeBookMarksColor());
  }

  // إضافة العنصر إلى العلامات المرجعية
  void addToBookMarks({required NewsModel newModel})async {
    bookMarks.add(newModel);
    await  box.put("ٍٍ${newModel.title}${newModel.publishedAt}",newModel);
    emit(BookMarksLoadedState(bookMarks)); // تحديث واجهة المستخدم
  }

  // إزالة العنصر من العلامات المرجعية
  void removeToBookMarks({required NewsModel newModel}) async{
    bookMarks.remove(newModel);
  await  box.delete("${newModel.title}${newModel.publishedAt}");
    emit(BookMarksLoadedState(bookMarks)); // تحديث واجهة المستخدم
  }


  getBookmarks() async {
 bookMarks=box.values.toList();
  }
}

