import 'package:collection/collection.dart';
import 'package:dart_date/dart_date.dart';

import '../constants/enums.dart';
import '../constants/fixed.dart';
import '../constants/relative.dart';
import '../helpers/date.dart';
import 'period.dart';

double daysInMonthAccurate = 146097.0 / 4800;
double daysInYearAccurate = 146097.0 / 400;

Duration unitDuration =
    const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999);

Duration yearDuration =
    Duration(milliseconds: (daysInYearAccurate * 24 * 60 * 60 * 1000).ceil());

class PeriodType {
  late String id;
  late String name;
  late Duration duration;
  late String category;
  late List<Period> _periods;
  late Function? _idGenerator;
  late Function? _nameGenerator;
  late int? year;
  late int? factor;
  late bool? startOfWeek;
  late String unit;
  late Map? offset;

  _getDuration() {
    switch (unit) {
      case "day":
        duration = unitDuration * (factor ?? 1);
        break;
      case "week":
        duration = unitDuration * (factor ?? 1) * 7;
        break;
      case "month":
        duration = Duration(
                milliseconds:
                    (daysInMonthAccurate * 24 * 60 * 60 * 1000).ceil()) *
            (factor ?? 1);
    }
  }

  PeriodType(Map<String, dynamic> object, {int? year}) {
    _init(object, year: year);
  }

  _init(Map<String, dynamic> config, {int? year}) {
    id = config['id'];
    name = config['name'];
    factor = config['factor'] ?? 1;
    category = config["category"];
    unit = config["unit"];
    _idGenerator = config['idGenerator'];
    _nameGenerator = config['nameGenerator'];
    startOfWeek = config['startOfWeek'] ?? false;
    offset = config['offset'];
    _getDuration();
    this.year = year;
    if (category == PeriodTypeCategory.FIXED) {
      _periods = _getFixedPeriods();
    } else if (category == PeriodTypeCategory.RELATIVE) {
      _periods = _getRelativePeriods(config);
    }
  }

  PeriodType.fromId(String id, {String? category, int? year}) {
    List<Map<String, dynamic>> periodTypeConfigs = [];
    if (category != null && category == PeriodTypeCategory.RELATIVE) {
      periodTypeConfigs.addAll(RELATIVE_PERIOD_TYPES);
    } else {
      periodTypeConfigs.addAll(FIXED_PERIODS_TYPES);
    }

    Map<String, dynamic> config = periodTypeConfigs
        .firstWhere((element) => element['id'] == id, orElse: () => {});
    if (config == {}) {
      throw Exception("Invalid period type id");
    }
    _init(config, year: year);
  }

  _getFixedPeriods() {
    int periodYear = year ?? DateTime.now().year;
    DateTime start = DateTime(periodYear);

    List<Interval> intervals = splitBy(
        Interval(start.startOfYear, start.endOfYear),
        unit: unit,
        factor: factor,
        offset: offset);

    return intervals
        .map((interval) => Period.fromInterval(interval,
            idGenerator: _idGenerator!,
            nameGenerator: _nameGenerator!,
            type: id,
            category: category))
        .toList();
  }

  _getRelativePeriods(Map<String, dynamic> object) {
    List<Map<String, dynamic>> periodObject = object['getPeriods']() ?? [];

    return periodObject
        .map((periodObject) =>
            Period.fromObject(periodObject, type: id, category: category))
        .toList();
  }

  static Period getPeriodById(String id) {
    int? year =
        int.tryParse(RegExp(r'^\d{4}').firstMatch(id)?.groups([0]).first ?? '');
    if (year != null) {
      Map<String, dynamic>? periodTypeObject =
          FIXED_PERIODS_TYPES.firstWhereOrNull(
        (type) => (type['regex'] as RegExp).hasMatch(id),
      );
      if (periodTypeObject == null) {
        throw "Invalid period id";
      }
      PeriodType periodType = PeriodType(periodTypeObject, year: year);
      List<Period> periods = periodType.periods;
      Period? period = periods.firstWhereOrNull((element) => element.id == id);
      if (period == null) {
        throw "Invalid period id";
      }
      return period;
    } else {
      Map<String, dynamic>? periodTypeObject = RELATIVE_PERIOD_TYPES
          .firstWhereOrNull((Map type) => (type['getPeriods']() as List)
              .where((element) => element['id'] as String == id)
              .isNotEmpty);

      if (periodTypeObject == null) {
        throw "Invalid period id";
      }
      PeriodType periodType = PeriodType(periodTypeObject);
      List<Period> periods = periodType.periods;
      Period? period = periods.firstWhereOrNull((element) => element.id == id);
      if (period == null) {
        throw "Invalid period id";
      }
      return period;
    }
  }

  get periods {
    return _periods;
  }
}
