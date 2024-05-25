part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileFetchLoading extends ProfileState {}

class ProfileFetchSuccess extends ProfileState {
  final ProfileModel profile;
  ProfileFetchSuccess({
    required this.profile,
  });
}

class ProfileFetchFailure extends ProfileState {
  final String error;
  ProfileFetchFailure({
    required this.error,
  });
}
