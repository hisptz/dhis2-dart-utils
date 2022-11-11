// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../../shared/helpers/mathematical_operations_util.dart';

///
/// `ProgramRuleHelper` is a collection of helper functions for evaluation of a `ProgramRule`
///
class ProgramRuleHelper {
  ///
  /// This is a helper function for evaluating the logical condition.
  /// It accepts the condition as a `String` and returns a `dynamic` value from the condition
  ///
  static dynamic evaluateLogicalCondition(String condition) {
    if (condition.contains('(') || condition.contains(')')) {
      int startIndex = condition.lastIndexOf('(');
      int endIndex = condition.indexOf(')', startIndex);
      String subCondition = condition.substring(startIndex, endIndex + 1);
      var value = evaluateLogicalConditionWithinBrackets(
          subCondition.replaceAll('(', '').replaceAll(')', ''));
      return evaluateLogicalCondition(
          condition.replaceAll(subCondition, '$value'));
    } else {
      var value = evaluateLogicalConditionWithinBrackets(condition);
      return value;
    }
  }

  ///
  /// `evaluateLogicalConditionWithinBrackets` evaluates the atomic condition having none of the brackets in it.
  /// The function accepts a `String` condition and returns a `dynamic` evaluated value.
  ///
  static dynamic evaluateLogicalConditionWithinBrackets(String condition) {
    return MathematicalOperationsUtil.evaluateMathematicalOperation(
      condition,
      resolveToNumber: false,
    );
  }
}
