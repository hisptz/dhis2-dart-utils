// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../constants/default_values.dart';
import '../constants/operators_constants.dart';

//
// `MathematicalOperationsUtil` is a collection of utilities for performing mathematical operations
//
class MathematicalOperationsUtil {
  //
  // `MathematicalOperationsUtil.sanitizeStringValue` sanitizes values ready for evaluations by other methods
  // It takes in a `dynamic` value as input and returns a sanitized value
  //
  static dynamic sanitizeStringValue(dynamic value) {
    String sanitizedValue =
        value == DefaultValues.dataObjectValue ? '0' : value;
    if (value.runtimeType == String) {
      value = sanitizedValue.replaceAll("'", '').trim();
      try {
        return double.parse(value);
      } catch (error) {
        return value;
      }
    } else if (value.runtimeType == int) {
      return value.toDouble();
    } else {
      return value;
    }
  }

  //
  // `MathematicalOperationsUtil.evaluateMathematicalOperation` is a helper function for performing all  supported mathematical operations on a given expression
  //  The method takes in s `String` expression and `bool` variable that decides if the function resolve to number.
  // This function return a `dynamic` value that represents the value from the expression
  //
  static dynamic evaluateMathematicalOperation(
    String expression, {
    bool resolveToNumber = false,
  }) {
    bool hasOperator = false;

    for (String arithmeticOperator in OperatorsConstants.arithmeticOperators) {
      int operatorIndex = expression.indexOf(arithmeticOperator);
      if (operatorIndex >= 0) {
        String leftOperand = expression.substring(0, operatorIndex).trim();
        String rightOperand = expression.substring(operatorIndex + 1).trim();
        if (!("'".allMatches(leftOperand).length % 2 == 1 &&
            "'".allMatches(leftOperand).length % 2 == 1)) {
          hasOperator = true;
          var leftValue =
              sanitizeStringValue(evaluateMathematicalOperation(leftOperand));
          var rightValue =
              sanitizeStringValue(evaluateMathematicalOperation(rightOperand));
          return evaluateArithmeticOperation(
            operator: arithmeticOperator,
            leftOperand: leftValue,
            rightOperand: rightValue,
          );
        }
      }
    }

    for (String logicalOperator in OperatorsConstants.logicalOperators) {
      int operatorIndex = expression.indexOf(logicalOperator);
      if (operatorIndex >= 0) {
        hasOperator = true;

        // TODO add a check for 0 and 1 in comparison
        String leftOperand = expression.substring(0, operatorIndex).trim();
        String rightOperand =
            expression.substring(operatorIndex + logicalOperator.length).trim();

        String leftValue = '${evaluateMathematicalOperation(leftOperand)}';
        String rightValue = '${evaluateMathematicalOperation(rightOperand)}';

        var sanitizedLeftValue = sanitizeStringValue(leftValue);
        var sanitizedRightValue = sanitizeStringValue(rightValue);

        try {
          var val = evaluateLogicalOperation(
            operator: logicalOperator,
            leftOperand: sanitizedLeftValue,
            rightOperand: sanitizedRightValue,
          );
          return val;
        } catch (e) {
          print('Error: $e');
          return false;
        }
      }
    }
    if (expression.contains('!')) {
      hasOperator = true;
      expression = expression.replaceAll('!', '');
      if (expression.toLowerCase() == 'true') {
        return false;
      } else if (expression.toLowerCase() == 'false') {
        return true;
      }
    }

    if (!hasOperator) {
      try {
        var value = expression.trim();
        return value.toLowerCase() == 'true'
            ? true
            : value.toLowerCase() == 'false'
                ? false
                : value;
      } catch (e) {
        return expression;
      }
    }
    return resolveToNumber == true ? 0 : false;
  }

  //
  // `MathematicalOperationsUtil.evaluateArithmeticOperation` is a helper function for evaluating arithmetic operation on a given expression
  // The method access a `String` operator, `dynamic` left operand and a `dynamic` right operand
  //  the expression returns the evaluated value
  //
  static evaluateArithmeticOperation({
    required String operator,
    required dynamic leftOperand,
    required dynamic rightOperand,
  }) {
    try {
      switch (operator) {
        case '+':
          return leftOperand + rightOperand;
        case '-':
          return leftOperand - rightOperand;
        case '*':
          return leftOperand * rightOperand;
        case '/':
          return leftOperand / rightOperand;
        case '%':
          return leftOperand % rightOperand;
      }
    } catch (e) {
      return 0;
    }
  }

  //
  // `MathematicalOperationsUtil.evaluateLogicalOperation` is a helper function for evaluating logical operation on a given expression
  // The method access a `String` operator, `dynamic` left operand and a `dynamic` right operand
  //  the expression returns the evaluated value
  //
  static evaluateLogicalOperation({
    required String operator,
    required dynamic leftOperand,
    required dynamic rightOperand,
  }) {
    // check for 1 and 0 used together with boolean operators
    if ([leftOperand, rightOperand]
            .any((operand) => [0.0, 1.0].contains(operand)) &&
        [leftOperand, rightOperand]
            .any((operand) => ['true', 'false'].contains('$operand'))) {
      leftOperand = leftOperand.runtimeType == double
          ? leftOperand == 1.0
              ? "true"
              : "false"
          : leftOperand;

      rightOperand = rightOperand.runtimeType == double
          ? rightOperand == 1.0
              ? "true"
              : "false"
          : rightOperand;
    }

    switch (operator) {
      case '>':
        return leftOperand > rightOperand;
      case '<':
        return leftOperand < rightOperand;
      case '>=':
        return leftOperand >= rightOperand;
      case '<=':
        return leftOperand <= rightOperand;
      case '!=':
        return leftOperand != rightOperand;
      case '===':
        return leftOperand == rightOperand;
      case '!':
        return '$rightOperand' != 'true';
      case '==':
        return leftOperand == rightOperand;
      case '&&':
        return ("$leftOperand" == "true") && ("$rightOperand" == "true");
      case '||':
        return ("$leftOperand" == "true") || ("$rightOperand" == "true");
    }
  }
}
