import 'package:hive/hive.dart';

part 'fillprofile_model.g.dart';

@HiveType(typeId: 1)
class FillprofileModel extends HiveObject {
  @HiveField(0)
  final String? pic;

  @HiveField(1)
  final String? Fullname;
  @HiveField(2)
  final String? Email;
  @HiveField(3)
  final String? phonenumber;

  FillprofileModel({
    required this.pic,
    required this.Fullname,
    required this.Email,
    required this.phonenumber,
  });



}