import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User extends HiveObject {

  @HiveField(0)
  String gmail;

  @HiveField(1)
  String password;

  User({required this.gmail, required this.password});
}