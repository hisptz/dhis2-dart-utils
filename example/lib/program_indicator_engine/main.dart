import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

void main() {
  // EXAMPLE: program indicator engine
  Map programIndicatorEngineDataObject = {
    "vV9UWAZohSf": 12,
    "qrur9Dvnyt5": 30,
    "GieVkTxp4HH": 0.4,
  };
  List<ProgramIndicator> programIndicators = [
    {
      "id": "yFTplrY7NaL",
      "aggregationType": "CUSTOM",
      "expression":
          "(#{Zj7UnCAulEk.vV9UWAZohSf} * #{Zj7UnCAulEk.GieVkTxp4HH}) + (#{Zj7UnCAulEk.qrur9Dvnyt5})",
      "program": "eBAyeGv0exc"
    },
    {
      "id": "mubfKE304dy",
      "aggregationType": "CUSTOM",
      "expression": "if(isNull(#{nabon8T5WUT.GR6MYw2N8j0}), 0, 1)",
      "program": "hcFmHC9yXgy"
    }
  ].map((indicator) => ProgramIndicator.fromMap(indicator)).toList();
  print(
    'Evaluation of $programIndicators based on $programIndicatorEngineDataObject = ${ProgramIndicatorEngine.evaluateProgramIndicators(
      programIndicators: programIndicators,
      dataObject: programIndicatorEngineDataObject,
    )}',
  );
}
