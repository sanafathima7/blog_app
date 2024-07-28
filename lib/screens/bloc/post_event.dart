import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostSubmitted extends PostEvent {
  final String title;
  final String content;

  const PostSubmitted({required this.title, required this.content});

  @override
  List<Object> get props => [title, content];
}

class PostErrorOccurred extends PostEvent {
  final String error;

  const PostErrorOccurred(this.error);

  @override
  List<Object> get props => [error];
}
