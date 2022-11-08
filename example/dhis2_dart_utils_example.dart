import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';
import 'package:dhis2_dart_utils/src/utils/program_indicator_engine/models/program_indicator.dart';
import 'package:dhis2_dart_utils/src/utils/program_rule_engine/models/program_rule.dart';
import 'package:dhis2_dart_utils/src/utils/program_rule_engine/models/program_rule_variable.dart';

void main() {
  // EXAMPLE: UID generator example
  print('Auto-generated UID from Core: ${Core.getUid()}');

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
    }
  ].map((indicator) => ProgramIndicator.fromMap(indicator)).toList();
  print(
    'Evaluation of $programIndicators based on $programIndicatorEngineDataObject = ${ProgramIndicatorEngine.evaluateProgramIndicators(
      programIndicators: programIndicators,
      dataObject: programIndicatorEngineDataObject,
    )}',
  );

  //  EXAMPLE: program rule engine
  List<ProgramRule> programRules = [
    {
      "id": "fd3wL1quxGb",
      "condition": "#{gender} == 'Male'",
      "program": "eBAyeGv0exc",
      "programRuleActions": [
        {
          "id": "IrmpncBsypT",
          "programRuleActionType": "HIDEFIELD",
          "programRule": "fd3wL1quxGb",
          "dataElement": "SWfdB5lX0fk",
          "programStageSection": "d7ZILSbPgYh"
        }
      ]
    },
    {
      "id": "xZe5qCzRS0Y",
      "condition": "#{gender} == 'Male'",
      "program": "lxAQ7Zs9VYR",
      "programRuleActions": [
        {
          "id": "hwgyO59SSxu",
          "programRuleActionType": "ASSIGN",
          "programRule": "xOe5qCzRS0Y",
          "dataElement": "sWoqcoByYmD",
          "data": "false"
        }
      ]
    },
    {
      "id": "xOe5qCzRS0Y",
      "condition": "!#{womanSmoking}",
      "program": "lxAQ7Zs9VYR",
      "programRuleActions": [
        {
          "id": "hwgyO59SSxu",
          "programRuleActionType": "HIDEFIELD",
          "programRule": "xOe5qCzRS0Y",
          "dataElement": "sWoqcoByYmD",
          "data": "false"
        }
      ]
    }
  ]
      .map((Map<String, dynamic> programRule) =>
          ProgramRule.fromMap(programRule))
      .toList();
  List<ProgramRuleVariable> programRuleVariables = [
    {
      "name": "gender",
      "id": "zINGRka3g9N",
      "programRuleVariableSourceType": "DATAELEMENT_NEWEST_EVENT_PROGRAM",
      "program": "eBAyeGv0exc",
      "dataElement": "oZg33kd9taw"
    },
    {
      "name": "womanSmoking",
      "id": "Z92dJO9gIje",
      "programRuleVariableSourceType": "DATAELEMENT_NEWEST_EVENT_PROGRAM",
      "program": "lxAQ7Zs9VYR",
      "dataElement": "sWoqcoByYmD"
    }
  ]
      .map((Map<String, dynamic> programRuleVariable) =>
          ProgramRuleVariable.fromMap(programRuleVariable))
      .toList();
  Map programRuleEngineDataObject = {
    "oZg33kd9taw": "Male",
  };

  print(
    '${ProgramRuleEngine.evaluateProgramRule(
      programRules: programRules,
      programRuleVariables: programRuleVariables,
      dataObject: programRuleEngineDataObject,
    )}',
  );
}
