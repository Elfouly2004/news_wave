
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Column(

      children: [

        CachedNetworkImage(
          imageUrl: widget.newModel.urlToImage??"",
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Text(widget.newModel.sourceModel?.name??""),

        Text(widget.newModel.title??"",

          maxLines: 1 ,   overflow:
          TextOverflow.ellipsis, ),

        Text(widget.newModel.desc??"",
          maxLines: 2,
          overflow:
          TextOverflow.ellipsis,
        ),

        Row(
          children: [
            Text(widget.newModel.sourceModel?.name??""),
            Icon(Icons.date_range),
            Text(convertDate(widget.newModel.publishedAt))
          ],
        )

      ],
    );
  }

  String  convertDate(dateString ) {


    DateTime dateTime = DateTime.parse(dateString);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
    // Output: 2024-09-12 – 07:05

    return formattedDate;
  }
}
