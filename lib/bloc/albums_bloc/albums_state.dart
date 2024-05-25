part of 'albums_bloc.dart';

@immutable
sealed class AlbumsState {}

final class AlbumsInitial extends AlbumsState {}

class AlbumsFetchLoading extends AlbumsState {}

class AlbumsFetchSuccess extends AlbumsState {
  final List<AlbumModel> albums;
  AlbumsFetchSuccess({
    required this.albums,
  });
}

class AlbumsFetchFailure extends AlbumsState {
  final String error;
  AlbumsFetchFailure({
    required this.error,
  });
}
