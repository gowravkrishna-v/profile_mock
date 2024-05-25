import 'package:profile_mock/model/profile_model.dart';
import 'package:profile_mock/repository/cloud_repository.dart';
import 'package:profile_mock/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalRepository localRepository;
  final CloudRepository cloudRepository;
  ProfileBloc({
    required this.cloudRepository,
    required this.localRepository,
  }) : super(ProfileInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileFetchLoading());
      bool isConnected = await cloudRepository.ping();
      if (isConnected) {
        var (ProfileModel profile, String err) =
            await cloudRepository.fetchProfile("1");
        if (err == "") {
          emit(ProfileFetchSuccess(profile: profile));
        } else {
          emit(ProfileFetchFailure(error: err));
        }
      } else {
        var (ProfileModel profile, String err) =
            await localRepository.fetchProfileFromLocal(1);
        if (err == "") {
          emit(ProfileFetchSuccess(profile: profile));
        } else {
          emit(ProfileFetchFailure(error: err));
        }
      }
    });
  }
}
