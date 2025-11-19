// import 'package:intl/intl.dart';

// class DateTimeUtils {
//   /// Format a DateTime into a string
//   static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
//     return DateFormat(pattern).format(date);
//   }

//   /// Parse a string into DateTime
//   static DateTime? parseDate(
//     String? dateString, {
//     String pattern = 'yyyy-MM-dd',
//   }) {
//     if (dateString == null) return null;
//     try {
//       return DateFormat(pattern).parse(dateString);
//     } catch (_) {
//       return null;
//     }
//   }

//   /// Convert to relative time (e.g., "2h ago")
//   static String timeAgo(DateTime dateTime) {
//     final duration = DateTime.now().difference(dateTime);

//     if (duration.inSeconds < 60) return "Just now";
//     if (duration.inMinutes < 60) return "${duration.inMinutes}m ago";
//     if (duration.inHours < 24) return "${duration.inHours}h ago";
//     if (duration.inDays < 7) return "${duration.inDays}d ago";

//     return formatDate(dateTime, pattern: 'MMM d, yyyy');
//   }

//   /// Returns start of the day (00:00:00)
//   static DateTime startOfDay(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }

//   /// Returns end of the day (23:59:59)
//   static DateTime endOfDay(DateTime date) {
//     return DateTime(date.year, date.month, date.day, 23, 59, 59);
//   }

//   /// Check if two dates are on the same day
//   static bool isSameDay(DateTime d1, DateTime d2) {
//     return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
//   }

//   /// Get difference in days (ignores time)
//   static int daysBetween(DateTime from, DateTime to) {
//     final fromDate = DateTime(from.year, from.month, from.day);
//     final toDate = DateTime(to.year, to.month, to.day);
//     return toDate.difference(fromDate).inDays;
//   }

//   /// Get difference in hours
//   static int hoursBetween(DateTime from, DateTime to) {
//     return to.difference(from).inHours;
//   }

//   /// Convert DateTime to ISO8601 string (e.g., 2025-09-03T14:30:00Z)
//   static String toIsoString(DateTime date) {
//     return date.toUtc().toIso8601String();
//   }

//   /// Parse ISO8601 string to DateTime
//   static DateTime? fromIsoString(String? isoString) {
//     if (isoString == null) return null;
//     try {
//       return DateTime.parse(isoString).toLocal();
//     } catch (_) {
//       return null;
//     }
//   }

//   /// Get current timestamp in milliseconds
//   static int currentTimestamp() {
//     return DateTime.now().millisecondsSinceEpoch;
//   }

//   /// Convert timestamp to DateTime
//   static DateTime fromTimestamp(int timestamp) {
//     return DateTime.fromMillisecondsSinceEpoch(timestamp);
//   }
// }
