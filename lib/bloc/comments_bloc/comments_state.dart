part of 'comments_bloc.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

class CommentsFetchLoading extends CommentsState {}

class CommentsFetchSuccess extends CommentsState {
  final List<CommentModel> comments;
  CommentsFetchSuccess({
    required this.comments,
  });
}

class CommentsFetchFailure extends CommentsState {
  final String error;
  CommentsFetchFailure({
    required this.error,
  });
}
