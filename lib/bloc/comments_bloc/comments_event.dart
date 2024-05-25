part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class FetchComments extends CommentsEvent {
  final String postId;
  FetchComments({
    required this.postId,
  });
}
