import 'package:profile_mock/utilities/connectivity_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'network_connectivity_event.dart';
part 'network_connectivity_state.dart';

class NetworkConnectivityBloc
    extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  static final NetworkConnectivityBloc _instance = NetworkConnectivityBloc._();

  factory NetworkConnectivityBloc() => _instance;

  NetworkConnectivityBloc._() : super(NetworkConnectivityInitial()) {
    on<NetworkObserve>((event, emit) {
      NetworkHelper.observeNetwork();
    });
    on<NetworkNotify>((event, emit) {
      event.isConnected
          ? emit(NetworkConnectivitySuccess())
          : emit(NetworkConnectivityFailure());
    });
  }
}
