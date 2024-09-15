import 'package:dartz/dartz.dart';
import 'package:newsapp/features/News/Data/Model/News_model.dart';

import '../../../../core/errors/failure.dart';


abstract class HomeRepo {


  Future<Either<Failure,List<NewsModel>>> getTopHeadline({required String category});


  Future<Either<Failure,List<NewsModel>>> searchForNews({required String q});


}