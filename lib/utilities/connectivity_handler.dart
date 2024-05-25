import 'package:profile_mock/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        NetworkConnectivityBloc().add(NetworkNotify(isConnected: true));
      } else {
        NetworkConnectivityBloc().add(NetworkNotify());
      }
    });
  }
}
