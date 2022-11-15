// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../shared/constants/string_constants.dart';
import '../shared/helpers/string_helpers.dart';
import 'constants/program_rule_actions_constants.dart';
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
        for (ProgramRuleAction programRuleAction
            in programRule.programRuleActions ?? []) {
          String sanitizedCondition = StringHelpers.escapeCharacter(
            condition,
            escapeChar: StringConstants.escapedCharacters,
          );
          String? data = programRuleAction.data;
          String? content = programRuleAction.content;
          String? evalDataCondition = programRuleAction.data;
          var dataElement = programRuleAction.dataElement;
          var trackedEntityAttribute = programRuleAction.trackedEntityAttribute;
          String? programRuleActionType =
              programRuleAction.programRuleActionType;
          var programStage = programRuleAction.programStage;
          var programStageSection = programRuleAction.programStageSection;
          for (ProgramRuleVariable programRuleVariable
              in programRuleVariables) {
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
                    dataObject[ruleVariableDataElementAttributeId]);
                value = doubleValue as String;
              } catch (error) {
                value = dataObject[ruleVariableDataElementAttributeId];
                if (dataObject[ruleVariableDataElementAttributeId] != '') {
                  value = dataObject[ruleVariableDataElementAttributeId];
                }
              }
              if (programRuleVariable.name != null &&
                  sanitizedCondition.contains(programRuleVariable.name!)) {
                sanitizedCondition = sanitizedCondition
                    .split("#{${programRuleVariable.name}}")
                    .join("'$value'");
              }
              if (data != null &&
                  programRuleVariable.name != null &&
                  data.contains(programRuleVariable.name!)) {
                evalDataCondition = evalDataCondition!
                    .split("#{${programRuleVariable.name}}")
                    .join("'$value'");
              }
            }
          }
          try {
            var condition =
                ProgramRuleHelper.evaluateLogicalCondition(sanitizedCondition);
            if (programRuleActionType ==
                    ProgramRuleActionsConstants.hideField &&
                condition.runtimeType == bool) {
              if (dataElement != null) {
                String id = dataElement;
                hiddenFields[id] = condition;
              } else if (trackedEntityAttribute != null) {
                String id = trackedEntityAttribute;
                hiddenFields[id] = condition;
              }
            } else if (programRuleActionType ==
                    ProgramRuleActionsConstants.assignField &&
                condition.runtimeType == bool) {
              String id = dataElement ?? (trackedEntityAttribute ?? '');
              if (id.isNotEmpty) {
                if (condition) {
                  assignedFields[id] =
                      ProgramRuleHelper.evaluateLogicalCondition(
                          evalDataCondition!);
                }
              }
            } else if (programRuleActionType ==
                    ProgramRuleActionsConstants.hideSection &&
                condition.runtimeType == bool) {
              if (programStageSection != null) {
                String sectionId = programStageSection;
                hiddenSections[sectionId] = condition;
              }
            } else if (programRuleActionType ==
                    ProgramRuleActionsConstants.hideProgramStage &&
                condition.runtimeType == bool) {
              if (programStage != null) {
                String stageId = programStage;
                hiddenSections[stageId] = condition;
              }
            } else if (condition.runtimeType == bool &&
                condition == true &&
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
              String? id = dataElement;
              errorOrWarningMessage[id] = {
                "message": content,
                "isComplete": isOnComplete,
                "messageType": messageType
              };
            } else if (condition.runtimeType == bool && condition == true) {
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
              if (dataElement != null) {
                String id = dataElement;
                errorOrWarningMessage[id] = {
                  message: message,
                  isOnComplete: isOnComplete,
                  messageType: messageType,
                };
              }
              if (trackedEntityAttribute != null) {
                String id = trackedEntityAttribute;
                errorOrWarningMessage[id] = {
                  message: message,
                  isOnComplete: isOnComplete,
                  messageType: messageType,
                };
              }
            }
          } catch (error) {
            //
          }
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
}
