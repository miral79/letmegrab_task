import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(
    String tag,
    String message, {
    dynamic data,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln("\n🛡️════════════════════════════════════════════════🛡️");
    buffer.writeln("[$tag] → $message");

    if (data != null) {
      buffer.writeln("📦 DATA:");
      buffer.writeln(_prettyPrint(data));
    }

    if (stackTrace != null) {
      buffer.writeln("🧵 STACK TRACE:");
      buffer.writeln(stackTrace.toString());
    }

    buffer.writeln("🛡️════════════════════════════════════════════════🛡️\n");

    debugPrint(buffer.toString());
  }

  static void info(String message, {dynamic data}) =>
      log("ℹ️ INFO", message, data: data);

  static void success(String message, {dynamic data}) =>
      log("✅ SUCCESS", message, data: data);

  static void warning(String message, {dynamic data}) =>
      log("⚠️ WARNING", message, data: data);

  static void error(String message, {dynamic error, StackTrace? stackTrace}) =>
      log("❌ ERROR", message, data: error, stackTrace: stackTrace);

  static String _prettyPrint(dynamic data) {
    try {
      if (data is String) {
        final decoded = jsonDecode(data);
        return const JsonEncoder.withIndent('  ').convert(decoded);
      } else if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (_) {
      return data.toString();
    }
  }
}
