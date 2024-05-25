import 'package:profile_mock/model/comment_model.dart';
import 'package:profile_mock/repository/cloud_repository.dart';
import 'package:profile_mock/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final LocalRepository localRepository;
  final CloudRepository cloudRepository;
  CommentsBloc({required this.cloudRepository, required this.localRepository})
      : super(CommentsInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentsFetchLoading());
      bool isConnected = await cloudRepository.ping();
      if (isConnected) {
        var (List<CommentModel> comments, String err) =
            await cloudRepository.fetchComments(event.postId);
        if (err == "") {
          emit(CommentsFetchSuccess(comments: comments));
        } else {
          emit(CommentsFetchFailure(error: err));
        }
      } else {
        var (List<CommentModel> comments, String err) = await localRepository
            .fetchCommentsFromLocal(int.parse(event.postId));
        if (err == "") {
          emit(CommentsFetchSuccess(comments: comments));
        } else {
          emit(CommentsFetchFailure(error: err));
        }
      }
    });
  }
}
