import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/utils/Appcolors.dart';

import '../../../Fill Profile/Data/model/fillprofile_model.dart';
import '../../Data/Model/News_model.dart';
import '../controller/get_top_headline/get_top_headline_cubit.dart';
import '../controller/get_top_headline/get_top_headline_states.dart';
import 'list_veiw_news.dart';

class Homebody_News extends StatefulWidget {
  const Homebody_News({super.key,});


  @override
  State<Homebody_News> createState() => _Homebody_NewsState();
}

class _Homebody_NewsState extends State<Homebody_News> {
  @override

  void initState() {
  
    super.initState();
    BlocProvider.of<TopHeadlineCubit>(context).getTopHeadline(
        category: "technology"
    );
  }


  @override
  Widget build(BuildContext context) {

    // final box = Hive.box<FillprofileModel>('ProfileBox');
    // final person= box.get("Data");


    return  RefreshIndicator(
      color: AppColors.blue,
      onRefresh: ()async{
        BlocProvider.of<TopHeadlineCubit>(context).getTopHeadline(category: "technology");
      },

      child:  Column(
        children: [

          BlocConsumer<TopHeadlineCubit, TopHeadlineStates>(
            listener: (context, state) {

              if(state is GetTopHeadlineFailureState ) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }

            },
            builder: (context, state) {


              return Expanded(child: state is GetTopHeadlineLoadingState?

              const Center(
                child: CircularProgressIndicator(),
              )
                  : state is GetTopHeadlineFailureState ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    Text(state.errorMessage),
                    TextButton(onPressed: ( ){
                      BlocProvider.of<TopHeadlineCubit>(context).getTopHeadline(
                          category: "technology"

                      );

                    } , child: Text("Try Again"))
                  ],
                ),
              ): ListViewForNews(news: BlocProvider
                  .of<TopHeadlineCubit>(context)
                  .topHeadlines,));


            },
          )
        ],
      ),
    );


  }
}


String  convertDate(dateString ) {

  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  // Output: 2024-09-12 – 07:05

  return formattedDate;
}