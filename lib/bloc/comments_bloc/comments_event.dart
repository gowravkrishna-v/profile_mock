part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class FetchComments extends CommentsEvent {
  final bool isConnected;
  final String postId;
  FetchComments({
    required this.isConnected,
    required this.postId,
  });
}
