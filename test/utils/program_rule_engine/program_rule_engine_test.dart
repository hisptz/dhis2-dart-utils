import 'package:dhis2_dart_utils/src/utils/program_rule_engine/models/program_rule.dart';
import 'package:dhis2_dart_utils/src/utils/program_rule_engine/models/program_rule_variable.dart';
import 'package:dhis2_dart_utils/src/utils/program_rule_engine/program_rule_engine.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

List<ProgramRule> programRules = [
  {
    "id": "PbSbImJMR4K",
    "condition":
        "#{gender of client} == 'Male' && d2:hasValue(A{Date of birth}) == true",
    "program": "eBAyeGv0exc",
    "programRuleActions": [
      {
        "id": "exRtxsdU7rn",
        "programRuleActionType": "ASSIGN",
        "programRule": "PbSbImJMR4K",
        "trackedEntityAttribute": "s5tV4k4buG9",
        "data": "d2:yearsBetween(A{Date of birth}, V{enrollment_date})"
      }
    ]
  },
  {
    "id": "fd3wL1quxGb",
    "condition": "#{gender of client} == 'Male'",
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
    "condition": "#{gender of client} == 'Male'",
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
    "condition": "!#{woman smoking}",
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
    .map((Map<String, dynamic> programRule) => ProgramRule.fromMap(programRule))
    .toList();
List<ProgramRuleVariable> programRuleVariables = [
  {
    "name": "gender of client",
    "id": "zINGRka3g9N",
    "programRuleVariableSourceType": "TEI_ATTRIBUTE",
    "program": "eBAyeGv0exc",
    "trackedEntityAttribute": "oZg33kd9taw"
  },
  {
    "name": "Date of birth",
    "id": "zINGRka3g9N",
    "programRuleVariableSourceType": "TEI_ATTRIBUTE",
    "program": "eBAyeGv0exc",
    "trackedEntityAttribute": "XZg33kd9taw"
  },
  {
    "name": "woman smoking",
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
  "XZg33kd9taw": "1997-03-07",
  "enrollmentDate": "2023-06-01"
};

void main() {
  group('Program rule engine test: ', () {
    dynamic programRuleEngineResults = ProgramRuleEngine.evaluateProgramRule(
      programRules: programRules,
      programRuleVariables: programRuleVariables,
      dataObject: programRuleEngineDataObject,
    );

    print(programRuleEngineResults);

    test('Does the engine return results object',
        () => {expect(programRuleEngineResults, isNotEmpty)});

    test(
        'Does the engine perform field hiding',
        (() => {
              expect(
                  programRuleEngineResults,
                  (Map expectedResult) =>
                      (expectedResult['hiddenFields'] as Map)
                          .values
                          .any((value) => value))
            }));

    test(
        'Does the engine perform field auto assignment',
        (() => {
              expect(
                  programRuleEngineResults,
                  (Map expectedResult) =>
                      (expectedResult['assignedFields'] as Map).isNotEmpty &&
                      (expectedResult['assignedFields'] as Map)
                          .values
                          .every((value) => "$value".isNotEmpty))
            }));
  });
}
