import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/models/post.dart' as postPackage;
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostSubmitted) {
      yield PostLoading();
      try {
        var box1 = await Hive.openBox<postPackage.postedQuestion>('postdata');
        var newPost = postPackage.postedQuestion(
          content: event.content,
          title: event.title,
          authId: 1,
          answer: '',
          isPublished: false,
        );

        await box1.add(newPost);
        await box1.close();
        yield PostSuccess();
      } catch (e) {
        yield PostError('Error saving user data: $e');
      }
    }
  }
}
