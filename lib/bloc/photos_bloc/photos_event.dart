part of 'photos_bloc.dart';

@immutable
sealed class PhotosEvent {}

class FetchPhotos extends PhotosEvent {
  final int albumId;
  FetchPhotos({
    required this.albumId,
  });
}
