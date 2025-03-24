import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionHandler {
  final _connectivity = Connectivity();
  late StreamSubscription _subscription;

  bool _connected = false;
  bool get connected => _connected;

  ConnectionHandler() {
    _connectivity.checkConnectivity().then((result) {
      _connected = result.any(
        (e) => e == ConnectivityResult.wifi || e == ConnectivityResult.mobile,
      );
    });
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      _connected = event.any((e) => e == ConnectivityResult.wifi || e == ConnectivityResult.mobile);
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
