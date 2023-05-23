// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../constants/default_values.dart';
import '../constants/operators_constants.dart';
import 'mathematical_operations_util.dart';

///
/// `D2OperationsUtils` is a util class for performing different built in DHIS2 operations
/// It has a collection of helper functions for DHIS2
///
class D2OperationsUtils {
  static bool _isValueNull(String value) {
    return value == DefaultValues.dataObjectValue;
  }

  ///
  /// `D2OperationsUtils.evaluatedD2BuiltInFunctions` function evaluates the D2 functions present in a expression.
  ///  It takes a `String` expression as a parameter and returns the results as a `String`
  ///
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
          .split(',');

      /// for `if` and `d2:condition` operators
      if (d2Expression.contains('d2:condition(') ||
          d2Expression.contains('if(')) {
        var condition = expressionSections.first.replaceAll("'", '');
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

      /// for `d2:hasValue` operator
      else if (d2Expression.contains('d2:hasValue(')) {
        bool expressionValue = !_isValueNull(expressionSections.first);
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      /// for `isNull` operator
      else if (d2Expression.contains('isNull(')) {
        bool expressionValue = _isValueNull(expressionSections.first);
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      /// for `isNotNull` operator
      else if (d2Expression.contains('isNotNull(')) {
        bool expressionValue = !_isValueNull(expressionSections.first);
        expression = expression.replaceRange(
            startIndex, endIndex + 1, "$expressionValue");
      }

      // TODO add condition for periods

      else {
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
