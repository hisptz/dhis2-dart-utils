import 'package:dart_date/dart_date.dart';

import '../helpers/date.dart';
import 'enums.dart';

List<Map<String, dynamic>> FIXED_PERIODS_TYPES = [
  {
    "id": PeriodTypes.WEEKLY,
    "name": "Weekly",
    "category": PeriodTypeCategory.FIXED,
    "regex": RegExp(r'^(\d{4})W(\d{1,2})$'), // YYYY"W"[1-53]
    "rank": 2,
    "unit": "week",
    "idGenerator": (Interval interval) =>
        "${interval.start.year}W${interval.start.getWeek}",
    "nameGenerator": (Interval interval) =>
        "Week ${interval.start.getWeek} ${formatDate(interval.start)} - ${formatDate(interval.end)}",
    "startOfWeek": true
  },
  {
    "id": PeriodTypes.WEEKLYWED,
    "name": "Weekly (Wednesday)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "week",
    "regex": RegExp(r'^([0-9]{4})(Wed)W([0-9]{1,2})$'), // YYYY"WedW"[1-53]
    "rank": 2,
    "offset": {
      "unit": "day",
      "value": 2,
    },
    "startOfWeek": true,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}WedW${interval.start.getWeek}",
    "nameGenerator": (Interval interval) =>
        "${"Week"} ${interval.start.getWeek} ${formatDate(interval.start)} - ${formatDate(interval.end)}",
  },
  {
    "id": PeriodTypes.WEEKLYTHU,
    "name": "Weekly (Thursday)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "week",
    "regex": RegExp(r'^([0-9]{4})(Thu)W([0-9]{1,2})$'), // YYYY"WedW"[1-53]
    "rank": 2,
    "offset": {
      "unit": "day",
      "value": 3,
    },
    "startOfWeek": true,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}ThuW${interval.start.getWeek}",
    "nameGenerator": (Interval interval) =>
        "${"Week"} ${interval.start.getWeek} ${formatDate(interval.start)} - ${formatDate(interval.end)}",
  },
  {
    "id": PeriodTypes.WEEKLYSAT,
    "name": "Weekly (Saturday)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "week",
    "regex": RegExp(r'^([0-9]{4})(Sat)W([0-9]{1,2})$'), // YYYY"WedW"[1-53]
    "rank": 2,
    "offset": {
      "unit": "day",
      "value": 5,
    },
    "startOfWeek": true,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}SatW${interval.start.getWeek}",
    "nameGenerator": (Interval interval) =>
        "${"Week"} ${interval.start.getWeek} ${formatDate(interval.start)} - ${formatDate(interval.end)}",
  },
  {
    "id": PeriodTypes.WEEKLYSUN,
    "name": "Weekly (Saturday)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "week",
    "regex": RegExp(r'^([0-9]{4})(Sun)W([0-9]{1,2})$'), // YYYY"WedW"[1-53]
    "rank": 2,
    "offset": {
      "unit": "day",
      "value": 6,
    },
    "startOfWeek": true,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}SunW${interval.start.getWeek}",
    "nameGenerator": (Interval interval) =>
        "${"Week"} ${interval.start.getWeek} ${formatDate(interval.start)} - ${formatDate(interval.end)}",
  },
  {
    "id": PeriodTypes.BIWEEKLY,
    "name": "Biweekly",
    "category": PeriodTypeCategory.FIXED,
    "unit": "week",
    "regex": RegExp(r'^([0-9]{4})BiW([0-9]{1,2})$'), // YYYY"BiW"[1-27]
    "rank": 3,
    "factor": 2,
    "startOfWeek": true,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}BiW${(interval.start.getWeek / 2).ceil()}",
    "nameGenerator": (Interval interval) =>
        "${"Bi-Week"} ${(interval.start.getWeek / 2).ceil()} ${formatDate(interval.start)} - ${formatDate(interval.end)}",
  },
  {
    "id": PeriodTypes.MONTHLY,
    "name": "Monthly",
    "category": PeriodTypeCategory.FIXED,
    "unit": "month",
    "regex": RegExp(r'^([0-9]{4})([0-9]{2})$'), // YYYYMM,
    "rank": 4,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}${interval.start.month.toString().padLeft(2, '0')}",
    "nameGenerator": (Interval interval) => interval.start.format('MMMM yyyy')
  },
  {
    "id": PeriodTypes.BIMONTHLY,
    "name": "Bi-monthly",
    "category": PeriodTypeCategory.FIXED,
    "unit": "month",
    "regex": RegExp(r'^([0-9]{4})([0-9]{2})B$'), // YYYY0[1-6]"B"
    "rank": 5,
    "factor": 2,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}${interval.start.month.toString().padLeft(2, '0')}B",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format('MMMM')} - ${interval.end.format('MMMM')} ${interval.start.year}"
  },
  {
    "id": PeriodTypes.QUARTERLY,
    "name": "Quarterly",
    "category": PeriodTypeCategory.FIXED,
    "unit": "quarter",
    "regex": RegExp(r'^([0-9]{4})Q([1234])$'), // YYYY"Q"[1-4]
    "rank": 6,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}Q${(interval.start.getMonth / 3).floor() + 1}",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format("MMMM")} - ${interval.end.format("MMMM")} ${interval.start.year}"
  },
  {
    "id": PeriodTypes.SIXMONTHLY,
    "name": "Six-monthly",
    "category": PeriodTypeCategory.FIXED,
    "unit": "quarter",
    "regex": RegExp(r'^([0-9]{4})S([12])$'), // YYYY"S"[1/2]
    "rank": 7,
    "factor": 2,
    "idGenerator": (Interval interval) =>
        "${interval.start.year}S${(interval.start.getMonth / 6).floor() + 1}",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format('MMMM')} - ${interval.end.format("MMMM")} ${interval.start.year}"
  },
  {
    "id": PeriodTypes.SIXMONTHLYAPR,
    "name": "Six-monthly (April)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "quarter",
    "regex": RegExp(r'^([0-9]{4})AprilS([12])$'), // YYYY"AprilS"[1/2]
    "rank": 7,
    "factor": 2,
    "offset": {"unit": "quarter", "value": 1},
    "idGenerator": (Interval interval) =>
        "${interval.start.year}AprilS${(interval.start.getMonth / 6).floor() + 1}",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format('MMMM')}${interval.start.year == interval.end.year ? ' ' : " ${interval.start.year} "}- ${interval.end.format('MMMM')} ${interval.end.year}"
  },
  {
    "id": PeriodTypes.YEARLY,
    "name": "Yearly",
    "category": PeriodTypeCategory.FIXED,
    "unit": "year",
    "regex": RegExp(r'^([0-9]{4})$'), // YYYY
    "rank": 8,
    "idGenerator": (Interval interval) => "${interval.start.year}",
    "nameGenerator": (Interval interval) => "${interval.start.year}",
  },
  {
    "id": PeriodTypes.FYNOV,
    "name": "Financial year (November)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "year",
    "regex": RegExp(r'^([0-9]{4})Nov$'), // YYYY"Nov"
    "rank": 8,
    "offset": {"unit": "month", "value": 10},
    "idGenerator": (Interval interval) => "${interval.start.year}Nov",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format("MMMM yyyy")} - ${interval.end.format("MMMM yyyy")}",
  },
  {
    "id": PeriodTypes.FYOCT,
    "name": "Financial year (October)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "year",
    "regex": RegExp(r'^([0-9]{4})Oct$'), // YYYY"Nov"
    "rank": 8,
    "offset": {"unit": "month", "value": 9},
    "idGenerator": (Interval interval) => "${interval.start.year}Oct",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format("MMMM yyyy")} - ${interval.end.format("MMMM yyyy")}",
  },
  {
    "id": PeriodTypes.FYJUL,
    "name": "Financial year (July)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "year",
    "regex": RegExp(r'^([0-9]{4})July$'), // YYYY"Nov"
    "rank": 8,
    "offset": {"unit": "month", "value": 6},
    "idGenerator": (Interval interval) => "${interval.start.year}July",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format("MMMM yyyy")} - ${interval.end.format("MMMM yyyy")}",
  },
  {
    "id": PeriodTypes.FYAPR,
    "name": "Financial year (April)",
    "category": PeriodTypeCategory.FIXED,
    "unit": "year",
    "regex": RegExp(r'^([0-9]{4})April$'), // YYYY"Nov"
    "rank": 8,
    "offset": {"unit": "month", "value": 3},
    "idGenerator": (Interval interval) => "${interval.start.year}April",
    "nameGenerator": (Interval interval) =>
        "${interval.start.format("MMMM yyyy")} - ${interval.end.format("MMMM yyyy")}",
  }
];
