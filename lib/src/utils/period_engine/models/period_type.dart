// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:dart_date/dart_date.dart';

import '../constants/period_categories.dart';
import '../constants/fixed_period_types.dart';
import '../constants/relative_period_types.dart';
import '../helpers/date.dart';
import 'period.dart';

double daysInMonthAccurate = 146097.0 / 4800;
double daysInYearAccurate = 146097.0 / 400;
Duration unitDuration =
    const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999);
Duration yearDuration =
    Duration(milliseconds: (daysInYearAccurate * 24 * 60 * 60 * 1000).ceil());

// This is modal class for DHIS2 period types
// It is a collection of different methods and  properties of the Period type
class PeriodType {
  // This is the id of the period type
  late String id;

  // This is the displayName of the period type
  late String name;

  // This is the duration of the period type. It conforms to the dart `Duration` class.
  late Duration duration;

  // This is the category of the period type
  late String category;

  // This is the list of all periods that falls into the period type. The _periods conform to the data type of List of `Period`
  late List<Period> _periods;

  // This is the period Id generator function
  late Function? _idGenerator;

  // This is the period type's name generator function
  late Function? _nameGenerator;

  // This is the integer value that represents the yearn of the period type
  late int? year;

  // This is the integer value for the period type factor
  late int? factor;

  // This is a boolean value for if the period type is a start of week
  late bool? startOfWeek;

  // This is the string representation of the period type's unit
  late String unit;

  // This is the offset value for the period class. It is is a nullable `Map` value.
  late Map? offset;

  // This is a private method for getting a period type's duration
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

  // This is the default constructor of the the Period type class
  // The default constructor accepts the `Map` object and an optional `int` period type year.
  PeriodType(Map<String, dynamic> object, {int? year}) {
    _init(object, year: year);
  }

  // This is the initialization function that generates the period type object based on the modal
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
    if (category == PeriodTypeCategory.fixed) {
      _periods = _getFixedPeriods();
    } else if (category == PeriodTypeCategory.relative) {
      _periods = _getRelativePeriods(config);
    }
  }

  // This is the constructor function that generates the Period Type from the period type ID.
  // The constructor takes in period type id as `String`, an optional period category as `String` and an optional year as `int`
  PeriodType.fromId(String id, {String? category, int? year}) {
    List<Map<String, dynamic>> periodTypeConfigs = [];
    if (category != null && category == PeriodTypeCategory.relative) {
      periodTypeConfigs.addAll(relativePeriodTypes);
    } else {
      periodTypeConfigs.addAll(fixedPeriodTypes);
    }

    Map<String, dynamic> config = periodTypeConfigs
        .firstWhere((element) => element['id'] == id, orElse: () => {});
    if (config.isEmpty) {
      throw Exception("Invalid period type id");
    }
    _init(config, year: year);
  }

  // This is a private method for getting fixed periods
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

  //
  _getRelativePeriods(Map<String, dynamic> object) {
    List<Map<String, dynamic>> periodObject = object['getPeriods']() ?? [];
    return periodObject
        .map((periodObject) =>
            Period.fromObject(periodObject, type: id, category: category))
        .toList();
  }

  // This is a static method for getting a period from the period types by using the period id
  // The method accepts the period Id and returns the `Period` object
  static Period getPeriodById(String id) {
    int? year =
        int.tryParse(RegExp(r'^\d{4}').firstMatch(id)?.groups([0]).first ?? '');
    if (year != null) {
      Map<String, dynamic>? periodTypeObject =
          fixedPeriodTypes.firstWhereOrNull(
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
      Map<String, dynamic>? periodTypeObject = relativePeriodTypes
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

  // this is a getter function for the periods from the current Period type object
  get periods {
    return _periods;
  }
}
