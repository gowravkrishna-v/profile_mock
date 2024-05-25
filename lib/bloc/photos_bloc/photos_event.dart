part of 'photos_bloc.dart';

@immutable
sealed class PhotosEvent {}

class FetchPhotos extends PhotosEvent {
  final int albumId;
  final bool isConnected;
  FetchPhotos({
    required this.isConnected,
    required this.albumId,
  });
}
