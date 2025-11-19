import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  bool get isOnline => _isOnline;

  NetworkManager() {
    _init();
  }

  void _init() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      _isOnline = result != ConnectivityResult.none;
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
