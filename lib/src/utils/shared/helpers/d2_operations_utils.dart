// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_dart_utils/src/utils/shared/helpers/date_helpers.dart';

import '../constants/default_values.dart';
import '../constants/operators_constants.dart';
import 'mathematical_operations_util.dart';

//
// `D2OperationsUtils` is a util class for performing different built in DHIS2 operations
// It has a collection of helper functions for DHIS2
//
class D2OperationsUtils {
  static bool _isValueNull(String value) {
    return value.isEmpty || value == DefaultValues.dataObjectValue;
  }

  //
  // `D2OperationsUtils.evaluatedD2BuiltInFunctions` function evaluates the D2 functions present in a expression.
  //  It takes a `String` expression as a parameter and returns the results as a `String`
  //
  static String evaluatedD2BuiltInFunctions(String expression) {
    var value = "0";
    var startIndex = expression.lastIndexOf(
      expression.contains("d2:") ? "d2:" : RegExp(r'if\(|isNull\(|isNotNull\('),
    );
    if (startIndex >= 0) {
      var endIndex = expression.indexOf(")", startIndex);
      var d2Expression = expression.substring(
        startIndex,
        endIndex + 1,
      );
      List<String> expressionSections = d2Expression
          .substring(
            d2Expression.indexOf('(') + 1,
            d2Expression.lastIndexOf(')'),
          )
          .split(',')
          .map((expressionSection) => expressionSection.trim())
          .toList();

      // for `if` and `d2:condition` operators
      if (d2Expression.contains('d2:condition(') ||
          d2Expression.contains('if(')) {
        var condition =
            expressionSections.first.replaceAll("'", '').replaceAll("'", '');
        var conditionResults =
            MathematicalOperationsUtil.evaluateMathematicalOperation(
          condition,
          resolveToNumber: false,
        );
        var d2ExpressionValue = conditionResults == true
            ? MathematicalOperationsUtil.evaluateMathematicalOperation(
                expressionSections[1],
                resolveToNumber: true,
              )
            : MathematicalOperationsUtil.evaluateMathematicalOperation(
                expressionSections[2],
                resolveToNumber: true,
              );
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$d2ExpressionValue");
      }

      // for `d2:hasValue` operator
      else if (d2Expression.contains('d2:hasValue(')) {
        String param = expressionSections.first.replaceAll("'", '').trim();
        bool expressionValue = !_isValueNull(param);
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // for `d2:ceil` operator
      else if (d2Expression.contains('d2:ceil(')) {
        double expressionValue =
            double.parse(expressionSections.first.replaceAll("'", ''))
                .ceilToDouble();
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // for `d2:modulus` operator
      else if (d2Expression.contains('d2:modulus(')) {
        double expressionValue =
            double.parse(expressionSections.first.replaceAll("'", '')) %
                double.parse(expressionSections.last.replaceAll("'", ''));
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // for `d2:floor` operator
      else if (d2Expression.contains('d2:floor(')) {
        double expressionValue =
            double.parse(expressionSections.first.replaceAll("'", ''))
                .floorToDouble();
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // for `d2:round` operator
      else if (d2Expression.contains('d2:round(')) {
        int decimalPlaces = expressionSections.length == 2
            ? int.parse(expressionSections.last.replaceAll("'", ''))
            : 0;
        String expressionValue =
            double.parse(expressionSections.first.replaceAll("'", ''))
                .toStringAsFixed(decimalPlaces);
        expression =
            expression.replaceRange(startIndex, endIndex + 1, expressionValue);
      }

      // for `isNull` operator
      else if (d2Expression.contains('isNull(')) {
        bool expressionValue =
            _isValueNull(expressionSections.first.replaceAll("'", ''));
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // for `isNotNull` operator
      else if (d2Expression.contains('isNotNull(')) {
        bool expressionValue =
            !_isValueNull(expressionSections.first.replaceAll("'", ''));
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // for `d2:daysBetween` operator
      else if (d2Expression.contains('d2:daysBetween(')) {
        if (expressionSections.length == 2) {
          var startDate =
              DateTime.parse(expressionSections.first.replaceAll("'", ''));
          var endDate =
              DateTime.parse(expressionSections.last.replaceAll("'", ''));
          int daysBetween = DateHelpers.calculateDaysBetweenDates(
            startDate: startDate,
            endDate: endDate,
          );
          value = '$daysBetween';
        }
        expression = expression.replaceRange(startIndex, endIndex + 1, value);
      }

      // for `d2:weeksBetween` operator
      else if (d2Expression.contains('d2:weeksBetween(')) {
        if (expressionSections.length == 2) {
          var startDate =
              DateTime.parse(expressionSections.first.replaceAll("'", ''));
          var endDate =
              DateTime.parse(expressionSections.last.replaceAll("'", ''));
          int weeksBetween = DateHelpers.calculateWeeksBetweenDates(
            startDate: startDate,
            endDate: endDate,
          );
          value = '$weeksBetween';
        }
        expression = expression.replaceRange(startIndex, endIndex + 1, value);
      }

      // for `d2:monthsBetween` operator
      else if (d2Expression.contains('d2:monthsBetween(')) {
        if (expressionSections.length == 2) {
          var startDate =
              DateTime.parse(expressionSections.first.replaceAll("'", ''));
          var endDate =
              DateTime.parse(expressionSections.last.replaceAll("'", ''));
          int monthsBetween = DateHelpers.calculateMonthsBetweenDates(
            startDate: startDate,
            endDate: endDate,
          );
          value = '$monthsBetween';
        }
        expression = expression.replaceRange(startIndex, endIndex + 1, value);
      }
      // for `d2:yearsBetween` operator
      else if (d2Expression.contains('d2:yearsBetween(')) {
        if (expressionSections.length == 2) {
          var startDate =
              DateTime.parse(expressionSections.first.replaceAll("'", ''));
          var endDate =
              DateTime.parse(expressionSections.last.replaceAll("'", ''));
          int yearsBetween = DateHelpers.calculateYearsBetweenDates(
            startDate: startDate,
            endDate: endDate,
          );
          value = '$yearsBetween';
        }
        expression = expression.replaceRange(startIndex, endIndex + 1, value);
      } else {
        expression = expression.replaceRange(startIndex, endIndex + 1, value);
      }
    } else {
      return expression;
    }

    return OperatorsConstants.dhis2Operators
            .any((operator) => expression.contains(operator))
        ? evaluatedD2BuiltInFunctions(expression)
        : expression;
  }
}
