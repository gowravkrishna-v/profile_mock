import 'package:profile_mock/model/album_model.dart';
import 'package:profile_mock/repository/cloud_repository.dart';
import 'package:profile_mock/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final LocalRepository localRepository;
  final CloudRepository cloudRepository;
  AlbumsBloc({
    required this.cloudRepository,
    required this.localRepository,
  }) : super(AlbumsInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumsFetchLoading());
      bool isConnected = await cloudRepository.ping();
      if (isConnected) {
        var (List<AlbumModel> albums, String err) =
            await cloudRepository.fetchAlbums("1");
        if (err == "") {
          emit(AlbumsFetchSuccess(albums: albums));
        } else {
          emit(AlbumsFetchFailure(error: err));
        }
      } else {
        var (List<AlbumModel> albums, String err) =
            await localRepository.fetchAlbumsFromLocal(1);
        if (err == "") {
          emit(AlbumsFetchSuccess(albums: albums));
        } else {
          emit(AlbumsFetchFailure(error: err));
        }
      }
    });
  }
}
