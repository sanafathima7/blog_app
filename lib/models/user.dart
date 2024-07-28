import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class userList extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String password;

  // @HiveField(3)
  // late int id;

  // @HiveField(4)
  // late bool isBanned;

  userList({
    required this.username,
    required this.email,
    required this.password,
    // required this.id,
    // required this.isBanned
  });
}
