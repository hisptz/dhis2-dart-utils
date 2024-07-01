// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../constants/fixed_period_types.dart';
import 'period_type.dart';

// This is data modal for period utility, that exposes methods for period utility
class PeriodUtility {
  // This method allow getting period type from period ID
  // The method takes period id as parameter and returns a `PeriodType`
  // Example
  // ```dart
  // var dailyPeriod = PeriodUtility.getPeriodTypeById('DAILY')  // This returns the Period type object for 'DAILY'
  // ```
  static getPeriodTypeById(String id) {
    List<Map<String, dynamic>> periodTypes = [...fixedPeriodTypes];
    Map<String, dynamic>? periodType = periodTypes
        .firstWhere((element) => element['id'] == id, orElse: () => {});
    return PeriodType(periodType);
  }
}
