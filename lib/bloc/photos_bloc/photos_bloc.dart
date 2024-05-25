import 'package:profile_mock/model/photo_model.dart';
import 'package:profile_mock/repository/cloud_repository.dart';
import 'package:profile_mock/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final LocalRepository localRepository;
  final CloudRepository cloudRepository;
  PhotosBloc({
    required this.cloudRepository,
    required this.localRepository,
  }) : super(PhotosInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotosFetchLoading());
      if (event.isConnected) {
        var (List<PhotoModel> photos, String err) =
            await cloudRepository.fetchPhotos(
          event.albumId.toString(),
        );
        if (err == "") {
          emit(PhotosFetchSuccess(photos: photos));
        } else {
          emit(PhotosFetchFailure(error: err));
        }
      } else {
        var (List<PhotoModel> photos, String err) =
            await localRepository.fetchPhotosFromLocal(
          event.albumId,
        );
        if (err == "") {
          emit(PhotosFetchSuccess(photos: photos));
        } else {
          emit(PhotosFetchFailure(error: err));
        }
      }
    });
  }
}
