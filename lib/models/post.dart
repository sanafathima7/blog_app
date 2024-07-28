import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class postedQuestion extends HiveObject {
  @HiveField(0)
  late String content;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late int authId;

  @HiveField(3)
  late String answer;

  @HiveField(4)
  late bool isPublished;

  postedQuestion({
    required this.content,
    required this.title,
    required this.authId,
    required this.answer,
    required this.isPublished,
  });
}
