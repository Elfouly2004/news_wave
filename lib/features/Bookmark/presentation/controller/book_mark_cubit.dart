import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../News/Data/Model/News_model.dart';
import 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkStates> {
  BookMarkCubit() : super(BookMarkInitialState());

  List<NewsModel> bookMarks = [];

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
  void addToBookMarks({required NewsModel newModel}) {
    bookMarks.add(newModel);

    emit(BookMarksLoadedState(bookMarks)); // تحديث واجهة المستخدم
  }

  // إزالة العنصر من العلامات المرجعية
  void removeToBookMarks({required NewsModel newModel}) {
    bookMarks.remove(newModel);

    emit(BookMarksLoadedState(bookMarks)); // تحديث واجهة المستخدم
  }

  // حفظ البيانات في Hive
  Future<void> saveBookmarks() async {
    var box = Hive.box<List<NewsModel>>("Saved_newsBox");
    await box.put("bookmark_key", bookMarks);
  }

  // استرجاع البيانات من Hive
  Future<void> getBookmarks() async {
    var box = Hive.box<List<NewsModel>>("Saved_newsBox");
    List<NewsModel>? savedNews = box.get("bookmark_key");

    if (savedNews != null) {
      bookMarks = savedNews;
      emit(BookMarksLoadedState(bookMarks));
    } else {
      emit(BookMarksLoadedState([]));
    }
  }
}

