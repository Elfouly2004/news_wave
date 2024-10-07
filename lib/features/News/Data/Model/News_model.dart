
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'News_model.g.dart';

@HiveType(typeId: 0)
class NewsModel extends Equatable {
  @HiveField(0)

  final String? title;
  @HiveField(1)

  final String? desc;
  @HiveField(2)
  final String ?content;

  @HiveField(3)
  final String ?urlToImage;

  @HiveField(4)
  final String ?url;

  @HiveField(5)
  final String? publishedAt;

  @HiveField(6)
  final SourceModel ?sourceModel;

  @HiveField(7)
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

  @override
  List<Object?> get props =>
      [title,desc,content,urlToImage,url,sourceModel,publishedAt];


}

@HiveType(typeId: 1)
class SourceModel extends Equatable{

  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String ?name ;

  SourceModel({required this.id, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,name
  ];

}
