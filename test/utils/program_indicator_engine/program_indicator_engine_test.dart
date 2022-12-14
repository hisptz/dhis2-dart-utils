import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';
import 'package:test/test.dart';

Map dataObject = {};
List<ProgramIndicator> programIndicators = [
  {
    "id": "yFTplrY7NaL",
    "aggregationType": "CUSTOM",
    "expression":
        "(#{Zj7UnCAulEk.vV9UWAZohSf} * #{Zj7UnCAulEk.GieVkTxp4HH}) + (#{Zj7UnCAulEk.qrur9Dvnyt5})",
    "program": {"id": "eBAyeGv0exc"}
  }
].map((indicator) => ProgramIndicator.fromMap(indicator)).toList();

void main() {
  group('Program indicator engine test: ', () {
    Map dataObject = {"vV9UWAZohSf": 12, "qrur9Dvnyt5": 30, "GieVkTxp4HH": 0.4};
    List<ProgramIndicator> programIndicators = [
      {
        "id": "yFTplrY7NaL",
        "aggregationType": "CUSTOM",
        "expression":
            "(#{Zj7UnCAulEk.vV9UWAZohSf} * #{Zj7UnCAulEk.GieVkTxp4HH}) + (#{Zj7UnCAulEk.qrur9Dvnyt5})",
        "program": "eBAyeGv0exc"
      }
    ].map((indicator) => ProgramIndicator.fromMap(indicator)).toList();

    var programIndicatorValue =
        ProgramIndicatorEngine.evaluateProgramIndicators(
      programIndicators: programIndicators,
      dataObject: dataObject,
    );

    test('Program indicator has value', () {
      expect(programIndicatorValue, isNotEmpty);
    });
  });
}
