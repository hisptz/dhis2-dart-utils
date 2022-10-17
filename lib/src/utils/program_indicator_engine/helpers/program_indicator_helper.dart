import '../../shared/constants/operators_constants.dart';
import '../../shared/helpers/data_object_helper.dart';
import '../../shared/helpers/mathematical_operations_util.dart';
import '../exceptions/program_indicator_exception.dart';
import '../models/program_indicator.dart';

class ProgramIndicatorHelper {
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

  static String evaluatedD2BuiltInFunctions(String expression) {
    var value = "0";
    var startIndex = expression.indexOf(
      expression.contains("d2:") ? "d2:" : "if(",
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
      } else {
        expression = expression.replaceRange(startIndex, endIndex + 1, value);
      }
    } else {
      return expression;
    }

    return expression;
  }

  static String evaluateArithmeticExpression(String expression) {
    String evaluatedValue = '0';
    try {
      expression = evaluatedD2BuiltInFunctions(expression);
      if (expression.contains('(') || expression.contains(')')) {
        int startIndex = expression.lastIndexOf('(');
        int endIndex = expression.indexOf(')', startIndex);
        String subExpression = expression.substring(startIndex, endIndex + 1);
        double value = evaluateExpressionWithinBrackets(
            subExpression.replaceAll('(', '').replaceAll(')', ''));
        evaluatedValue = evaluateArithmeticExpression(
            expression.replaceAll(subExpression, '$value'));
      } else {
        double value = evaluateExpressionWithinBrackets(expression);
        evaluatedValue = value.toStringAsFixed(1);
      }
    } catch (e) {
      throw ProgramIndicatorException('evaluateArithmeticExpression: $e');
    }
    evaluatedValue =
        ['Infinity', 'NaN'].contains(evaluatedValue) ? '0' : evaluatedValue;
    return double.parse(evaluatedValue).toStringAsFixed(1);
  }

  static List<String> getUidsFromExpression(String expression) {
    RegExp regExp = RegExp('(#{.*?})');
    List<String> matchedUids = [];
    try {
      Iterable<Match> matches = regExp.allMatches(expression);
      for (Match m in matches) {
        matchedUids.add(m[0]!);
      }
    } catch (e) {
      throw ProgramIndicatorException('getUidsFromExpression: $e');
    }

    return matchedUids;
  }

  static String getExpressionWithValues(
      String expression, List<String> uids, Map dataObject) {
    try {
      for (String uid in uids) {
        String value = DataObjectHelper.getValueFromDataObject(uid, dataObject);
        expression = expression.replaceAll(uid, value);
      }
      return expression;
    } catch (e) {
      throw ProgramIndicatorException('getExpressionWithValues: $e');
    }
  }

  static String evaluateExpressionValueFromProgramIndicator({
    required ProgramIndicator programIndicator,
    Map dataObject = const {},
  }) {
    String expression = programIndicator.expression ?? '';
    var uids = getUidsFromExpression(expression);
    expression = getExpressionWithValues(expression, uids, dataObject);
    return evaluateArithmeticExpression(expression);
  }
}
