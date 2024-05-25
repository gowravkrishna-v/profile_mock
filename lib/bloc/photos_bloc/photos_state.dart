part of 'photos_bloc.dart';

@immutable
sealed class PhotosState {}

final class PhotosInitial extends PhotosState {}

class PhotosFetchLoading extends PhotosState {}

class PhotosFetchSuccess extends PhotosState {
  final List<PhotoModel> photos;
  PhotosFetchSuccess({
    required this.photos,
  });
}

class PhotosFetchFailure extends PhotosState {
  final String error;
  PhotosFetchFailure({
    required this.error,
  });
}
