import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'constants.dart';

class NetworkService {
  StreamController<ConnectivityStatus> controller = StreamController();

  NetworkService() {
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      controller.add(_connectivityStatus(connectivityResult));
    });
  }

  ConnectivityStatus _connectivityStatus(
      ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi
        ? ConnectivityStatus.connected
        : ConnectivityStatus.disconnected;
  }
}
