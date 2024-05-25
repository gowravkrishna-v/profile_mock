part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

class PostsInitial extends PostsState {}

class PostFetchLoading extends PostsState {}

class PostsFetchSuccess extends PostsState {
  final List<PostModel> posts;
  PostsFetchSuccess({
    required this.posts,
  });
}

class PostsFetchFailure extends PostsState {
  final String error;
  PostsFetchFailure({
    required this.error,
  });
}
