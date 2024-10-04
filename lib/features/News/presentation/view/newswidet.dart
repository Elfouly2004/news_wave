
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/utils/Appcolors.dart';

import '../../../Bookmark/presentation/controller/book_mark_cubit.dart';
import '../../../Bookmark/presentation/controller/book_mark_state.dart';
import '../../Data/Model/News_model.dart';

class NewWidget extends StatefulWidget {
  const NewWidget({super.key, required this.newModel});

  final NewsModel newModel;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    var bookMarkCubit  =BlocProvider.of<BookMarkCubit>(context);
    return BlocBuilder<BookMarkCubit, BookMarkStates>(
      builder: (context, state) {
        return           Card(
          color: Colors. grey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.newModel.urlToImage??"",
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),


                  ),
                ),

                Text(widget.newModel.sourceModel?.name??""),

                RichText(
                    maxLines: 2 ,overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: "${widget.newModel.sourceModel?.name} :" ??"",
                        style: TextStyle(color: AppColors.black, fontWeight:FontWeight.bold),
                        children: [
                          TextSpan(text:widget.newModel.title??"",
                              style: TextStyle(color: Colors.black54,))

                        ]
                    )),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [

                        Text(widget.newModel.sourceModel?.name??""),
                        SizedBox(width: 10,),
                        Icon(CupertinoIcons.clock ,size: 15,),
                        Text(convertDate(widget.newModel.publishedAt))


                      ],
                    ),

                    IconButton(onPressed: () {

                      bookMarkCubit.changeBookMark(widget.newModel);
                    }, icon: widget.newModel.bookMark ?Icon(CupertinoIcons.bookmark_fill):Icon(CupertinoIcons.bookmark),
                      color: widget.newModel.bookMark ? AppColors.blue:Colors.black,)

                  ],
                ),

              ],
            ),
          ),
        );
      },

    );
  }

  String  convertDate(dateString ) {


    DateTime dateTime = DateTime.parse(dateString);

    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
    // Output: 2024-09-12 – 07:05

    String formattedDate = DateFormat('kk:mm').format(dateTime);


    return formattedDate;
  }
}
