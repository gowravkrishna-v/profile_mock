part of 'network_connectivity_bloc.dart';

@immutable
sealed class NetworkConnectivityState {}

class NetworkConnectivityInitial extends NetworkConnectivityState {}

class NetworkConnectivitySuccess extends NetworkConnectivityState {}

class NetworkConnectivityFailure extends NetworkConnectivityState {}
