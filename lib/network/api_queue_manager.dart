import 'package:dio/dio.dart' as dio;

typedef ApiCall = Future<dio.Response> Function();

class ApiQueueManager {
  final List<ApiCall> _queue = [];

  void add(ApiCall call) {
    _queue.add(call);
  }

  Future<void> retryPending() async {
    final pending = List<ApiCall>.from(_queue);
    _queue.clear();

    for (final call in pending) {
      try {
        await call();
      } catch (e) {
        // If the call fails, add it back to the queue
        add(call);
      }
    }
  }

  bool get hasPending => _queue.isNotEmpty;

  int get pendingCount => _queue.length;
}
