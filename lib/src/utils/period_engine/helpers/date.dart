import 'package:dart_date/dart_date.dart';

addOffset(DateTime date, Map offset) {
  int value = offset['value'];
  String unit = offset['unit'];
  switch (unit) {
    case "day":
      DateTime updatedDate = date.startOfDay;
      int count = value;
      while (count > 0) {
        updatedDate = updatedDate.nextDay;
        count--;
      }
      return updatedDate;
    case "week":
      DateTime updatedDate = date.startOfISOWeek;
      int count = value;
      while (count > 0) {
        updatedDate = updatedDate.nextWeek;
        count--;
      }
      return updatedDate;
    case "month":
      DateTime updatedDate = date.startOfMonth;
      int count = value;
      while (count > 0) {
        updatedDate = updatedDate.nextMonth;
        count--;
      }
      return updatedDate;
    case "quarter":
      DateTime updatedDate = date.startOfMonth;
      int count = (value) * 3;
      while (count > 0) {
        updatedDate = updatedDate.nextMonth;
        count--;
      }
      return updatedDate;
  }
}

String formatDate(
  DateTime date,
) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

List<Interval> splitBy(Interval interval,
    {required String unit, int? factor, Map? offset}) {
  List<Interval> intervals = [];

  bool hasOffset = offset != null;

  DateTime start = interval.start;
  DateTime end = interval.end;

  if (unit == "week") {
    start = start.startOfISOWeek;
  }

  if (hasOffset) {
    start = addOffset(start, offset);
    end = addOffset(end, offset);
  }

  switch (unit) {
    case "day":
      while (start < end) {
        intervals.add(Interval(start.startOfDay, end.endOfDay));
        start = start.nextDay;
      }
      break;
    case "week":
      while (start < end) {
        DateTime localStart = start;
        DateTime localEnd = start;

        if (localStart.year != interval.start.year) {
          start = localEnd.nextWeek;
          continue;
        }
        if (factor != null && factor > 1) {
          int factorCount = factor - 1;
          while (factorCount > 0) {
            localEnd = localEnd.nextWeek;
            factorCount--;
          }
        }
        intervals.add(Interval(localStart, localEnd.endOfISOWeek));
        start = localEnd.nextWeek;
      }
      break;
    case "month":
      while (start < end) {
        DateTime localStart = start.startOfMonth;
        DateTime localEnd = start.startOfMonth;
        if (factor != null && factor > 1) {
          int factorCount = factor - 1;
          while (factorCount > 0) {
            localEnd = localEnd.nextMonth;
            factorCount--;
          }
        }
        intervals.add(Interval(localStart, localEnd.endOfMonth));
        start = localEnd.startOfMonth.nextMonth;
      }
      break;
    case "quarter":
      while (start < end) {
        DateTime localStart = start.startOfMonth;
        DateTime localEnd = start.startOfMonth;
        int factorCount = 3 * (factor ?? 1) - 1;

        while (factorCount > 0) {
          localEnd = localEnd.nextMonth;
          factorCount--;
        }

        intervals.add(Interval(localStart.startOfMonth, localEnd.endOfMonth));
        start = localEnd.nextMonth.startOfMonth;
      }
      break;
    case "year":
      int year = start.year;
      int count = 10;
      while (count >= 0) {
        DateTime localStart = DateTime(year - count).startOfYear;
        DateTime localEnd = localStart.endOfYear;
        if (hasOffset) {
          localStart = addOffset(localStart, offset);
          localEnd = addOffset(localEnd, offset);
        }
        intervals.add(Interval(localStart, localEnd));
        count--;
      }
  }

  return intervals;
}
