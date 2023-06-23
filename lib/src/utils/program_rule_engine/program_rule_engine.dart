// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_dart_utils/src/utils/shared/constants/dhis2_variables.dart';

import '../shared/constants/string_constants.dart';
import '../shared/helpers/string_helpers.dart';
import 'constants/program_rule_actions_constants.dart';
import 'exceptions/program_rule_exception.dart';
import 'helpers/program_rule_helper.dart';
import 'models/program_rule.dart';
import 'models/program_rule_action.dart';
import 'models/program_rule_variable.dart';

///
/// `ProgramRuleEngine` is the engine class for evaluation of DHI2 program rules
///
class ProgramRuleEngine {
  ///
  /// `ProgramRuleEngine.evaluateProgramRule` is a helper function for evaluation of program rule on given form data object
  ///  The function takes a list of `ProgramRule`, a list of `ProgramRuleVariable` and a `Map` of form data object to return a `Map` result
  ///  The result from this function follows below format:
  /// ```dart
  ///   {
  ///     "hiddenFields" : {...}
  ///     "assignedFields" : {...}
  ///     "hiddenSections" : {...}
  ///     "hiddenProgramStages" : {...}
  ///     "errorOrWarningMessage" : {...}
  ///   }
  /// ```
  ///
  static Map evaluateProgramRule({
    required List<ProgramRule> programRules,
    required List<ProgramRuleVariable> programRuleVariables,
    Map dataObject = const {},
  }) {
    var hiddenFields = {};
    var assignedFields = {};
    var hiddenSections = {};
    var hiddenProgramStages = {};
    var errorOrWarningMessage = {};

    if (programRules.isNotEmpty) {
      for (ProgramRule programRule in programRules) {
        String condition = programRule.condition ?? '';
        String sanitizedCondition = StringHelpers.escapeCharacter(
          condition,
          escapeChar: StringConstants.escapedCharacters,
        );

        // Decoding the expression with program rule variables
        sanitizedCondition = decodeExpressionWithProgramRuleVariables(
          programRuleVariables: programRuleVariables,
          expression: sanitizedCondition,
          dataObject: dataObject,
        );

        try {
          // Evaluating the logical condition
          var evaluatedConditionResults =
              ProgramRuleHelper.evaluateLogicalCondition(sanitizedCondition);

          for (ProgramRuleAction programRuleAction
              in programRule.programRuleActions ?? []) {
            String? data = programRuleAction.data;
            String? content = programRuleAction.content;
            String dataExpression = programRuleAction.data ?? '';
            String? programRuleActionType =
                programRuleAction.programRuleActionType;
            var dataElement = programRuleAction.dataElement;
            var trackedEntityAttribute =
                programRuleAction.trackedEntityAttribute;
            var programStage = programRuleAction.programStage;
            var programStageSection = programRuleAction.programStageSection;

            String dataItemTargetedByProgramAction =
                (dataElement ?? '').isNotEmpty
                    ? dataElement!
                    : (trackedEntityAttribute ?? '').isNotEmpty
                        ? trackedEntityAttribute!
                        : (programStage ?? '').isNotEmpty
                            ? programStage!
                            : (programStageSection ?? '').isNotEmpty
                                ? programStageSection!
                                : '';

            // Decoding the expression with program rule variables
            dataExpression = decodeExpressionWithProgramRuleVariables(
              programRuleVariables: programRuleVariables,
              expression: dataExpression,
              dataObject: dataObject,
            );
            if (programRuleActionType ==
                    ProgramRuleActionsConstants.hideField &&
                evaluatedConditionResults.runtimeType == bool) {
              hiddenFields[dataItemTargetedByProgramAction] =
                  evaluatedConditionResults;
            } else if (programRuleActionType ==
                    ProgramRuleActionsConstants.assignField &&
                evaluatedConditionResults.runtimeType == bool) {
              if (dataItemTargetedByProgramAction.isNotEmpty) {
                if (evaluatedConditionResults) {
                  var sanitizedDataExpression = escapeStandardDhis2Variables(
                    expression: dataExpression,
                    dataObject: dataObject,
                  );
                  var assignedValue = StringHelpers.escapeQuotes(
                    ProgramRuleHelper.evaluateLogicalCondition(
                      sanitizedDataExpression,
                    ),
                  );
                  assignedFields[dataItemTargetedByProgramAction] =
                      assignedValue;
                }
              }
            } else if (programRuleActionType ==
                    ProgramRuleActionsConstants.hideSection &&
                evaluatedConditionResults.runtimeType == bool) {
              if (programStageSection?.isNotEmpty == true) {
                String sectionId = programStageSection!;
                hiddenSections[sectionId] = evaluatedConditionResults;
              }
            } else if (programRuleActionType ==
                    ProgramRuleActionsConstants.hideProgramStage &&
                evaluatedConditionResults.runtimeType == bool) {
              if (programStage?.isNotEmpty == true) {
                String stageId = programStage!;
                hiddenSections[stageId] = evaluatedConditionResults;
              }
            } else if (evaluatedConditionResults.runtimeType == bool &&
                evaluatedConditionResults == true &&
                (programRuleActionType ==
                        ProgramRuleActionsConstants.showError ||
                    programRuleActionType ==
                        ProgramRuleActionsConstants.showWarning ||
                    programRuleActionType ==
                        ProgramRuleActionsConstants.warningOnComplete ||
                    programRuleActionType ==
                        ProgramRuleActionsConstants.errorOnComplete)) {
              String messageType = programRuleActionType ==
                          ProgramRuleActionsConstants.showError ||
                      programRuleActionType ==
                          ProgramRuleActionsConstants.errorOnComplete
                  ? 'error'
                  : 'warning';
              bool isOnComplete = programRuleActionType ==
                          ProgramRuleActionsConstants.warningOnComplete ||
                      programRuleActionType ==
                          ProgramRuleActionsConstants.errorOnComplete
                  ? true
                  : false;
              errorOrWarningMessage[dataItemTargetedByProgramAction] = {
                "message": content,
                "isComplete": isOnComplete,
                "messageType": messageType
              };
            } else if (evaluatedConditionResults.runtimeType == bool &&
                evaluatedConditionResults == true) {
              var message = '';
              String messageType = programRuleActionType ==
                          ProgramRuleActionsConstants.showError ||
                      programRuleActionType ==
                          ProgramRuleActionsConstants.errorOnComplete
                  ? 'error'
                  : 'warning';
              bool isOnComplete = programRuleActionType ==
                          ProgramRuleActionsConstants.warningOnComplete ||
                      programRuleActionType ==
                          ProgramRuleActionsConstants.errorOnComplete
                  ? true
                  : false;
              if (content != null) {
                message += content;
              }
              if (data != null) {
                message += ' $data';
              }
              errorOrWarningMessage[dataItemTargetedByProgramAction] = {
                  message: message,
                  isOnComplete: isOnComplete,
                  messageType: messageType,
              };
            }
          }
        } catch (error) {
          var exception = ProgramRuleException(
              'evaluateProgramRule(${programRule.id}): $error');
          print(exception.toString());
        }
      }
    }

    return {
      "hiddenFields": hiddenFields,
      "assignedFields": assignedFields,
      "hiddenSections": hiddenSections,
      "hiddenProgramStages": hiddenProgramStages,
      "errorOrWarningMessage": errorOrWarningMessage
    };
  }

  ///
  /// `ProgramRuleEngine.decodeExpressionWithProgramRuleVariables` is a helper function that decodes and expression by replacing data object values with the program rule variables
  ///  The function accepts `String` expression, `Map` data object and a `List` of `ProgramRuleVariable` .
  ///  It returns a sanitized `String` expression
  static String decodeExpressionWithProgramRuleVariables({
    required String expression,
    required List<ProgramRuleVariable> programRuleVariables,
    Map dataObject = const {},
  }) {
    String sanitizedExpression = expression;

    for (ProgramRuleVariable programRuleVariable in programRuleVariables) {
      String ruleVariableDataElementAttributeId =
          programRuleVariable.dataElement != null &&
                  programRuleVariable.dataElement != ''
              ? programRuleVariable.dataElement!
              : programRuleVariable.trackedEntityAttribute != null &&
                      programRuleVariable.trackedEntityAttribute != ''
                  ? programRuleVariable.trackedEntityAttribute!
                  : '';
      var value = "''";
      if (dataObject.isNotEmpty &&
          dataObject[ruleVariableDataElementAttributeId] != null) {
        try {
          double doubleValue = double.parse(
            dataObject[ruleVariableDataElementAttributeId] ?? '0.0',
          );
          value = doubleValue as String;
        } catch (error) {
          value = "${dataObject[ruleVariableDataElementAttributeId]}";
          if (dataObject[ruleVariableDataElementAttributeId] != '') {
            value = "${dataObject[ruleVariableDataElementAttributeId]}";
          }
        }

        sanitizedExpression = escapeStandardDhis2Variables(
          dataObject: dataObject,
          expression: sanitizedExpression,
        );

        if (programRuleVariable.name != null &&
            sanitizedExpression.contains(programRuleVariable.name!)) {
          sanitizedExpression = ProgramRuleHelper.sanitizeExpression(
            expression: sanitizedExpression,
            programRuleVariable: programRuleVariable.name ?? '',
            value: value,
          );
        }
      }
    }
    return sanitizedExpression;
  }

  ///
  /// Replacing the DHIS2 standard variables with values from data object
  ///
  static String escapeStandardDhis2Variables({
    String expression = '',
    Map dataObject = const {},
  }) {
    var dhis2Variables = Dhis2Variables.getStandardVariables();
    if (dhis2Variables.any(
      (variable) => expression.contains(variable),
    )) {
      for (var variable in dhis2Variables) {
        String sanitizedVariable =
            StringHelpers.convertSnakeCaseToCamelCase(variable);
        expression = dataObject.keys.contains(sanitizedVariable)
            ? ProgramRuleHelper.sanitizeExpression(
                expression: expression,
                programRuleVariable: variable,
                value: dataObject[sanitizedVariable],
              )
            : expression;
      }
    }

    return expression;
  }
}
