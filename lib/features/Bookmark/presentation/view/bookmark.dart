

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../News/presentation/view/list_veiw_news.dart';
import '../controller/book_mark_cubit.dart';
import '../controller/book_mark_state.dart';

class BookMarksScreen extends StatelessWidget {
  const BookMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bookMarkCubit = BlocProvider.of<BookMarkCubit>(context);
    return BlocBuilder<BookMarkCubit, BookMarkStates>(
      builder: (context, state) {
        return ListViewForNews(
          news: bookMarkCubit.bookMarks.toSet().toList(),
        );
      },
    );
  }

}


// {
//   "title" :"ziad" ,
// "name": "ziad",
// }
// {
// "title" :"ziad" ,
// "name": "ziad",
// }
