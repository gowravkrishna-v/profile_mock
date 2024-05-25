part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class FetchUserProfile extends ProfileEvent {
  final bool isConnected;
  FetchUserProfile({required this.isConnected});
}
