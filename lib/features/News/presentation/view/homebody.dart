import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/utils/Appcolors.dart';
import 'package:newsapp/features/Bookmark/presentation/controller/book_mark_cubit.dart';
import 'package:newsapp/features/News/presentation/view/widgets/SearchScreen.dart';
import 'package:newsapp/features/Topic/presentation/controller/categories_cubit.dart';
import '../../../../sharedwidget/Search.dart';
import '../../../Fill Profile/Data/model/fillprofile_model.dart';
import '../../Data/Model/News_model.dart';
import '../controller/get_top_headline/get_top_headline_cubit.dart';
import '../controller/get_top_headline/get_top_headline_states.dart';
import '../controller/search_cubit/search_cubit.dart';
import '../controller/search_cubit/search_state.dart';
import 'list_veiw_news.dart';




class Homebody_News extends StatefulWidget {
  const Homebody_News({super.key});

  @override
  State<Homebody_News> createState() => _Homebody_NewsState();
}

class _Homebody_NewsState extends State<Homebody_News> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopHeadlineCubit>(context).getTopHeadline(
        category: "technology",
      bookmarksList: BlocProvider.of<BookMarkCubit>(context).bookMarks,
      index: 0
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.blue,
      onRefresh: () async {
        BlocProvider.of<TopHeadlineCubit>(context).getTopHeadline(
          bookmarksList: BlocProvider.of<BookMarkCubit>(context).bookMarks,

          category: "technology",
                index: 0,
        );
      },
      child: Column(
        children: [



       Padding(
         padding: const EdgeInsets.all(8.0),
         child: GestureDetector(
           onTap:() {
             Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
           },
           child: Container(
             height: MediaQuery.sizeOf(context).height*0.07,
             width: MediaQuery.sizeOf(context).width*0.9,
             decoration: BoxDecoration(
               color: AppColors.white,
               border: Border.all(color: AppColors.blue,width: 2)
             ),

             child: Row(
               children: [
                 SizedBox(width: 10,),
                 Icon(CupertinoIcons.search, size: 30, color: AppColors.blue),
                 SizedBox(width: 10,),
                 Text("Search",style: TextStyle(color: AppColors.blue, fontSize: 20),)
               ],
             ),

           ),
         ),
       ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Search_feild(
          //     onChanged: (Q) {
          //       BlocProvider.of<SearchCubit>(context).getSearch(q: Q.trim());
          //     },
          //   ),
          // ),

          // Search BlocConsumer
             BlocConsumer<TopHeadlineCubit, TopHeadlineStates>(
                listener: (context, state) {


                  if (state is GetTopHeadlineFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {


                  // int key=BlocProvider.of<CategoriesCubit>(context).categoryIndex;
                  List<NewsModel>?news=BlocProvider.of<TopHeadlineCubit>(context).mapfornews[0];


                  if (state is GetTopHeadlineLoadingState &&news==null
                      ||state is GetTopHeadlineLoadingState &&news!.isEmpty ) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is GetTopHeadlineFailureState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error),
                          Text(state.errorMessage),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<TopHeadlineCubit>(context).getTopHeadline(
                                  category: "technology",
                                  bookmarksList: BlocProvider.of<BookMarkCubit>(context).bookMarks,

                                  index: 0);
                            },
                            child: const Text("Try Again"),
                          ),
                        ],
                      ),
                    );
                  }

                  // Display top headlines if search is not active
                  return Expanded(
                    child: ListViewForNews(news:news!),
                  );
                },
              ),

        ],
      ),
    );
  }
}

// Function to convert date string to formatted date
String convertDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  return formattedDate;
}
