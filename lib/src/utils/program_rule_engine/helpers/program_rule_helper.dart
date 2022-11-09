import '../../shared/helpers/mathematical_operations_util.dart';

class ProgramRuleHelper {
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

  static dynamic evaluateLogicalConditionWithinBrackets(String condition) {
    return MathematicalOperationsUtil.evaluateMathematicalOperation(
      condition,
      resolveToNumber: false,
    );
  }
}
