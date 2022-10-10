import '../constants/operators_constants.dart';

class MathematicalOperationsUtil {
  static dynamic sanitizeStringValue(dynamic value) {
    if (value.runtimeType == String) {
      value = value.replaceAll(RegExp(r'[\s]+'), '').replaceAll("'", '').trim();
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
        String leftOperand = expression.substring(0, operatorIndex).trim();
        String rightOperand =
            expression.substring(operatorIndex + logicalOperator.length).trim();

        String leftValue = '${evaluateMathematicalOperation(leftOperand)}';
        String rightValue = '${evaluateMathematicalOperation(rightOperand)}';

        var sanitizedLeftValue = sanitizeStringValue(leftValue);
        var sanitizedRightValue = sanitizeStringValue(rightValue);
        return evaluateLogicalOperation(
          operator: logicalOperator,
          leftOperand: sanitizedLeftValue,
          rightOperand: sanitizedRightValue,
        );
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
        double value = double.parse(expression.trim());
        return value;
      } catch (e) {
        return expression.toLowerCase() == 'true'
            ? true
            : expression.toLowerCase() == 'false'
                ? false
                : expression;
      }
    }
    return resolveToNumber == true ? 0 : false;
  }

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

  static evaluateLogicalOperation({
    required String operator,
    required dynamic leftOperand,
    required dynamic rightOperand,
  }) {
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
      case '==':
        return leftOperand == rightOperand;
      case '&&':
        return ("$leftOperand" == "true") && ("$rightOperand" == "true");
      case '||':
        return ("$leftOperand" == "true") || ("$rightOperand" == "true");
    }
  }
}
