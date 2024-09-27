
class NewsModel {
  final String? title;
  final String? desc;
  final String ?content;
  final String ?urlToImage;
  final String ?url;
  final String? publishedAt;
  final SourceModel ?sourceModel;
  bool bookMark ;
  NewsModel(
      {
    required this.title,
    required this.desc,
    required this.content,
    required this.urlToImage,
    required this.url,
    required this.publishedAt,
    required this.sourceModel,
    this.bookMark= false
  }
  );


}


class SourceModel {
  final String? id;
  final String ?name ;

  SourceModel({required this.id, required this.name});

}
