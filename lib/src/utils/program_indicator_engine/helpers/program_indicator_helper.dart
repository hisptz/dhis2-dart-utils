// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../../shared/constants/string_constants.dart';
import '../../shared/constants/operators_constants.dart';
import '../../shared/helpers/d2_operations_utils.dart';
import '../../shared/helpers/data_object_helper.dart';
import '../../shared/helpers/mathematical_operations_util.dart';
import '../../shared/helpers/string_helpers.dart';
import '../exceptions/program_indicator_exception.dart';
import '../models/program_indicator.dart';

///
/// This is a class having a collection of helper methods for evaluation of program indicator
///
class ProgramIndicatorHelper {
  ///
  /// `evaluateExpressionWithinBrackets` is the method that breaks down an expression to its core based on brackets
  ///  It takes in a `String` expression and returns a `Double` value from the expression
  ///
  static double evaluateExpressionWithinBrackets(String expression) {
    bool hasOperator = false;
    for (String operator in OperatorsConstants.arithmeticOperators) {
      int operatorIndex = expression.indexOf(operator);
      if (operatorIndex >= 0) {
        hasOperator = true;
        String leftOperand = expression.substring(0, operatorIndex).trim();
        String rightOperand = expression.substring(operatorIndex + 1).trim();

        double leftValue = evaluateExpressionWithinBrackets(leftOperand);
        double rightValue = evaluateExpressionWithinBrackets(rightOperand);

        return MathematicalOperationsUtil.evaluateArithmeticOperation(
          operator: operator,
          leftOperand: leftValue,
          rightOperand: rightValue,
        );
      }
    }
    if (!hasOperator) {
      try {
        double value = double.parse(expression.trim());
        return value;
      } catch (e) {
        return 0;
      }
    }
    return 0;
  }

  ///
  /// `evaluateArithmeticExpression` function evaluates the arithmetic expression
  ///  The function takes in a `String` expression and return the resulted `String` value
  ///
  static String evaluateArithmeticExpression(
      String expression, String programIndicatorId) {
    String evaluatedValue = '0';
    try {
      expression = D2OperationsUtils.evaluatedD2BuiltInFunctions(expression);
      if (expression.contains('(') || expression.contains(')')) {
        int startIndex = expression.lastIndexOf('(');
        int endIndex = expression.indexOf(')', startIndex);
        String subExpression = expression.substring(startIndex, endIndex + 1);
        double value = evaluateExpressionWithinBrackets(
            subExpression.replaceAll('(', '').replaceAll(')', ''));
        evaluatedValue = evaluateArithmeticExpression(
          expression.replaceAll(subExpression, '$value'),
          programIndicatorId,
        );
      } else {
        double value = evaluateExpressionWithinBrackets(expression);
        evaluatedValue = value.toStringAsFixed(1);
      }
    } catch (e) {
      var exception = ProgramIndicatorException(
          'evaluateArithmeticExpression($programIndicatorId): $e');
      print(exception.toString());
    }
    evaluatedValue =
        ['Infinity', 'NaN'].contains(evaluatedValue) ? '0' : evaluatedValue;
    return double.parse(evaluatedValue).toStringAsFixed(1);
  }

  ///
  /// `getUidsFromExpression` helper function translates the expression by collecting the dataElement Uids from the expression
  /// Its takes in a `String` expression and `String` program indicator id as parameters and returns a `List` of uids that are contained in the expression
  ///
  static List<String> getUidsFromExpression(
    String expression,
    String programIndicatorId,
  ) {
    RegExp regExp = RegExp('(#{.*?})');
    List<String> matchedUids = [];
    try {
      Iterable<Match> matches = regExp.allMatches(expression);
      for (Match match in matches) {
        matchedUids.add(match[0]!);
      }
    } catch (e) {
      var exception = ProgramIndicatorException(
          'getUidsFromExpression($programIndicatorId): $e');
      print(exception.toString());
    }

    return matchedUids;
  }

  ///
  /// `getExpressionWithValues` helper function translates the expression with the existing values from the form data object
  ///  The functions takes parameters as `String` expression, `List` of contained uids ana a `Map` form data object
  ///  This function return a `String` expression that is substituted with the data object values
  ///
  static String getExpressionWithValues(
      String expression, List<String> uids, Map dataObject) {
    try {
      for (String uid in uids) {
        String value = DataObjectHelper.getValueFromDataObject(uid, dataObject);
        expression = expression.replaceAll(uid, value);
      }
    } catch (e) {
      var exception = ProgramIndicatorException('getExpressionWithValues: $e');
      print(exception.toString());
    }
    return expression;
  }

  ///
  /// `evaluateExpressionValueFromProgramIndicator` is the helper function to start evaluation of the program indicator
  /// The function takes in `ProgramIndicator` and a `Map` form data object.
  /// After evaluation, the function returns the `String` result from the expression
  ///
  static String evaluateExpressionValueFromProgramIndicator({
    required ProgramIndicator programIndicator,
    Map dataObject = const {},
  }) {
    String expression = StringHelpers.escapeCharacter(
      programIndicator.expression ?? '',
      escapeChar: StringConstants.escapedCharacters,
    );
    var uids = getUidsFromExpression(
      expression,
      programIndicator.id ?? '',
    );
    expression = getExpressionWithValues(expression, uids, dataObject);
    return evaluateArithmeticExpression(
      expression,
      programIndicator.id ?? '',
    );
  }
}
