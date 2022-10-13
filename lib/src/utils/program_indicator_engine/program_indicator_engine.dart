import 'helpers/program_indicator_helper.dart';
import 'models/program_indicator.dart';

class ProgramIndicatorEngine {
  static Map evaluateProgramIndicators(
      {required List<ProgramIndicator> programIndicators,
      Map dataObject = const {}}) {
    Map evaluatedValues = {};
    for (ProgramIndicator programIndicator in programIndicators) {
      String value =
          ProgramIndicatorHelper.evaluateExpressionValueFromProgramIndicator(
              programIndicator: programIndicator, dataObject: dataObject);
      evaluatedValues[programIndicator.id] = value;
    }
    return evaluatedValues;
  }
}
