import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/repository/cloud_repository.dart';
import 'package:profile_mock/repository/local_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final LocalRepository localRepository;
  final CloudRepository cloudRepository;
  PostsBloc({
    required this.cloudRepository,
    required this.localRepository,
  }) : super(PostsInitial()) {
    on<FetchPosts>(
      (event, emit) async {
        emit(PostFetchLoading());
        if (event.isConnected) {
          var (List<PostModel> posts, String err) =
              await cloudRepository.fetchPosts("1");
          if (err == "") {
            emit(PostsFetchSuccess(posts: posts));
          } else {
            emit(PostsFetchFailure(error: err));
          }
        } else {
          var (List<PostModel> posts, String err) =
              await localRepository.fetchPostsFromLocal(1);
          if (err == "") {
            emit(PostsFetchSuccess(posts: posts));
          } else {
            emit(PostsFetchFailure(error: err));
          }
        }
      },
    );
  }
}
